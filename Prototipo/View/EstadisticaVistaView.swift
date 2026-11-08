import SwiftUI

struct EstadisticaVistaView: View {
    
    @StateObject private var api = Consumo_Api()
    @State private var listaCandidatos: [Candidato] = []

    @State private var buscar = ""
    @State private var mensajeActualizar = false
    @State private var cargando = false
    @State private var tipoOrden: TipoOrden = .votos

    enum TipoOrden {
        case votos, alfabetico
    }
    
    //logica
    private var totalVotosGlobales: Int {
        listaCandidatos.reduce(0) { $0 + $1.totalVotos }
    }
    
    private func porcentajeNumerico(votos: Int) -> Double {
        let total = totalVotosGlobales
        if total == 0 { return 0.0 }
        return (Double(votos) / Double(total)) * 100
    }
    
    private func porcentajeString(votos: Int) -> String {
        return String(format: "%.1f%%", porcentajeNumerico(votos: votos))
    }
    
    // Logica filtro
    var candidatosFiltrados: [Candidato] {
        let filtrados = buscar.isEmpty ? listaCandidatos : listaCandidatos.filter {
            $0.partido.nombrePartido.localizedCaseInsensitiveContains(buscar) ||
            $0.nombreCompleto.localizedCaseInsensitiveContains(buscar)
        }
        
        switch tipoOrden {
        case .votos:
            // mayor a mnor
            return filtrados.sorted { $0.totalVotos > $1.totalVotos }
        case .alfabetico:
            // alfabetico
            return filtrados.sorted { $0.partido.nombrePartido < $1.partido.nombrePartido }
        }
    }
    
    var datosParaGrafico: [Candidato] {
        Array(candidatosFiltrados.prefix(5))
    }
    
    //pagina
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // botn volver
                    HStack {
                        NavigationLink(destination: HomeView()) {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.blue)
                            Text("Volver")
                                .font(.title3)
                                .bold()
                                .padding(.leading, 5)
                        }
                    }
                    
                    //desplegable ordenar
                    HStack {
                        Menu("Ordenar por") {
                            Button("Más populares") { tipoOrden = .votos }
                            Button("Por orden alfabético") { tipoOrden = .alfabetico }
                        }
                        .buttonStyle(.bordered)
                        .tint(.blue)
                        
                        Spacer()
                        
                        Button {
                            Task { await cargarDatos() }
                            mensajeActualizar = true
                        } label: {
                            if cargando {
                                ProgressView()
                            } else {
                                Label("Actualizar", systemImage: "arrow.clockwise")
                            }
                        }
                        .buttonStyle(.bordered)
                        .tint(.blue)
                        .alert("Lista Actualizada!", isPresented: $mensajeActualizar) {
                            Button("OK") {}
                        }
                    }
                    
                    Divider()
                    
                    //grafico
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Tabla Partidos")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        if listaCandidatos.isEmpty && cargando {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding()
                        } else if datosParaGrafico.isEmpty {
                            Text("No hay datos para mostrar.")
                                .font(.caption)
                                .foregroundColor(.gray)
                        } else {
                            ForEach(datosParaGrafico) { candidato in
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack {
                                        Text(candidato.partido.nombrePartido)
                                            .font(.subheadline)
                                            .bold()
                                        Spacer()
                                        Text(porcentajeString(votos: candidato.totalVotos))
                                            .font(.caption)
                                            .bold()
                                    }
                                    
                                    //barrita visual
                                    GeometryReader { geo in
                                        ZStack(alignment: .leading) {
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.2))
                                                .cornerRadius(4)
                                            
                                            Rectangle()
                                                .fill(Color.blue.gradient)
                                                .frame(width: max(geo.size.width * (porcentajeNumerico(votos: candidato.totalVotos) / 100), 0))
                                                .cornerRadius(4)
                                        }
                                    }
                                    .frame(height: 10)
                                }
                                Divider()
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(12)
                    
                    //buscador
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Buscar partido...", text: $buscar)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    //tarjetas
                    ForEach(candidatosFiltrados) { candidato in
                        NavigationLink(destination: DetalleCandidatoView(candidato: candidato)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(candidato.partido.nombrePartido)
                                        .bold()
                                        .foregroundColor(.black)
                                        .font(.title3)
                                    
                                    Text("Candidato: \(candidato.nombreCompleto)")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                    
                                    HStack {
                                        Text("Votos: \(candidato.totalVotos)")
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(width: 180, alignment: .leading)
                                }
                                .padding()
                                
                                Spacer()
                                
                                AsyncImage(url: URL(string: candidato.partido.imagenPartidoURL)) { phase in
                                    if let image = phase.image {
                                        image.resizable().scaledToFit()
                                    } else {
                                        if phase.error != nil {
                                            Image(systemName: "photo").foregroundColor(.gray)
                                        } else {
                                            ProgressView()
                                        }
                                    }
                                }
                                .frame(width: 80, height: 80)
                                .padding()
                            }
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(12)
                            .padding(.vertical, 5)
                        }
                    }
                }
                .navigationTitle("Estadísticas")
                .padding()
            }
        }
        .task {
            await cargarDatos()
        }
    }
    
    func cargarDatos() async {
        cargando = true
        do {
            self.listaCandidatos = try await api.fetchTodosCandidatos()
        } catch {
            print("Error cargando datos: \(error.localizedDescription)")
        }
        cargando = false
    }
}

#Preview {
    EstadisticaVistaView()
}
