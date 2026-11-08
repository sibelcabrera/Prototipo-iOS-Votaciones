import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case apiError(String)
    case voteConflict
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "La URL de la API es inválida."
        case .invalidResponse:
            return "Respuesta HTTP inválida del servidor."
        case .voteConflict:
            return "Ya has votado por un candidato."
        case .apiError(let message):
            return "Error de la API: \(message)"
        }
    }
}

class Consumo_Api: ObservableObject {
    
    private let baseURL = "https://narvaez.alwaysdata.net/"
    private let decoder = JSONDecoder()
    
    // Obtener lista completa de candidatos
    func fetchTodosCandidatos() async throws -> [Candidato] {
        
        let endpoint = baseURL + "get_todos_candidatos_full.php"
        
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            return try decoder.decode([Candidato].self, from: data)
        } catch {
            throw APIError.apiError("Error leyendo los datos de candidatos.")
        }
    }
    
    // Obtener lista de eventos del calendario
    func fetchEventos() async throws -> [Evento] {
        
        let endpoint = baseURL + "get_eventos.php"
        
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            return try decoder.decode([Evento].self, from: data)
        } catch {
            throw APIError.apiError("Error leyendo los datos de eventos.")
        }
    }
    
    // Registrar Voto (POST)
    func registrarVoto(candidatoID: Int, firebaseUID: String) async throws {
        
        let endpoint = baseURL + "post_voto.php"
        
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        let body: [String: Any] = [
            "id_candidato": candidatoID,
            "id_usuario": firebaseUID
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 201:
            return
            
        case 409:
            throw APIError.voteConflict
            
        default:
            throw APIError.apiError("HTTP \(httpResponse.statusCode)")
        }
    }
}
