import SwiftUI

struct HomeView: View {
    
    @StateObject private var api = Consumo_Api()
    @State private var candidatos: [Candidato] = []
    @State private var cargando = true
    
    @State private var idPartidoSeleccionado: Int? = nil
    
    var body: some View {
        VStack {
            
            Image("home")
                .resizable()
                .scaledToFit()
                .frame(width: 55)
                .padding(.trailing, 300)
            
            HStack(spacing: 8) {
                Text("Todos")
                    .botonTodos()
                    .onTapGesture { idPartidoSeleccionado = nil }
                
                Text("Favoritos")
                    .botonCategoria()
                    .onTapGesture { idPartidoSeleccionado = 1 }
                
                Text("Populares")
                    .botonCategoria()
                    .onTapGesture { idPartidoSeleccionado = 2 }
                
                Text("Top 10")
                    .botonCategoria()
                    .onTapGesture { idPartidoSeleccionado = 3 }
            }
            
            if cargando {
                ProgressView("Cargando candidatos...")
                    .padding()
            } else {
                List {
                    ForEach(candidatos.filter { candidato in
                        if let id = idPartidoSeleccionado {
                            return candidato.partido.idPartido == id
                        }
                        return true
                    }) { candidato in
                        
                        NavigationLink {
                            Proyecto1View(candidato: candidato)
                        } label: {
                            HStack(spacing: 12) {
                                
                                AsyncImage(url: URL(string: candidato.partido.imagenPartidoURL)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .scaledToFill()
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    Text(candidato.partido.nombrePartido)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    
                                    Text("Partido político")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text("Ver más")
                                    .padding(.vertical, 3)
                                    .padding(.horizontal, 10)
                                    .background(Color.color3)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
            }
            
            Divider()
        }
        .task {
            await cargarCandidatos()
        }
    }
    
    func cargarCandidatos() async {
        do {
            let lista = try await api.fetchTodosCandidatos()
            
            await MainActor.run {
                self.candidatos = lista
                self.cargando = false
            }
            
        } catch {
            print("Error cargando candidatos:", error.localizedDescription)
        }
    }
}
