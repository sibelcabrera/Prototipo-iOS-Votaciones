import Foundation

struct Partido: Codable {
    let idPartido: Int
    let nombrePartido: String
    let imagenPartidoURL: String
    
    enum CodingKeys: String, CodingKey {
        case idPartido = "id_partido"
        case nombrePartido = "nombre_partido"
        case imagenPartidoURL = "imagen_partido_url"
    }
}

struct Propuesta: Codable {
    let resumen: String
    let detalleCompleto: String
    
    enum CodingKeys: String, CodingKey {
        case resumen
        case detalleCompleto = "detalle_completo"
    }
}

struct Candidato: Codable, Identifiable {
    
    let id: Int
    let nombreCompleto: String
    let totalVotos: Int
    let imagenCandidatoURL: String
    
    let profesion: String
    let fechaNacimiento: String
    let lugarNacimiento: String
    
    let propuesta: Propuesta
    let partido: Partido
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id_candidato"
        case nombreCompleto = "nombre_completo"
        case totalVotos = "total_votos"
        case imagenCandidatoURL = "imagen_candidato_url"
        case profesion
        case fechaNacimiento = "fecha_nacimiento"
        case lugarNacimiento = "lugar_nacimiento"
        case propuesta
        case partido
    }
}

struct Evento: Codable, Identifiable {
    
    let id: Int
    
    let nombre: String
    let dia: String
    let mes: String
    let rangoFechas: String
    let ubicacion: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id_evento"
        case nombre = "nombre_evento"
        case dia
        case mes
        case rangoFechas = "date_range"
        case ubicacion = "location"
    }
}
