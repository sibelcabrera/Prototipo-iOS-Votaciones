import SwiftUI

struct DetalleCandidatoView: View {
    
    let candidato: Candidato
    @EnvironmentObject var fViewModel: FirebaseViewModel
    @EnvironmentObject var tabManager: TabStateManager
    @Environment(\.dismiss) var dismiss
    
    @State private var votando = false
    @State private var mensaje = ""
    @State private var mostrarAlerta = false
    @State private var mostrarConfirmacion = false
    
    @State private var yaVoto = false
    
    @State private var api = Consumo_Api()
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    
                    HStack(spacing: 15) {
                        AsyncImage(url: URL(string: candidato.partido.imagenPartidoURL)) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(candidato.partido.nombrePartido)
                                .font(.headline)
                                .foregroundColor(Color.color3)
                            Text("Partido político")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.gray.opacity(0.15), radius: 8, x: 0, y: 4)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Propuesta política")
                            .font(.headline)
                            .foregroundColor(Color.color3)
                        Text(candidato.propuesta.detalleCompleto)
                            .font(.body)
                            .foregroundColor(.black)
                            .lineSpacing(4)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.gray.opacity(0.1), radius: 6, x: 0, y: 3)
                    .padding(.horizontal)
                    
                    HStack(spacing: 20) {
                        
                        Button {
                            guard fViewModel.user?.email != nil else {
                                mensaje = "Error: No se identificó al usuario."
                                mostrarAlerta = true
                                return
                            }
                            mostrarConfirmacion = true
                            
                        } label: {
                            if votando {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            } else {
                                Text(yaVoto ? "Voto Enviado" : "Votar")
                                    .font(.system(size: 16, weight: .bold))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(yaVoto ? Color.gray : Color.color3)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                        }
                        .disabled(votando || yaVoto)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 30)
                }
                .padding(.top, 20)
            }
            .navigationTitle(candidato.partido.nombrePartido)
            .navigationBarTitleDisplayMode(.inline)
        }
        
        .onAppear {
            if let userEmail = fViewModel.user?.email {
                let claveUnica = "voto_realizado_\(userEmail)_\(candidato.id)"
                if UserDefaults.standard.bool(forKey: claveUnica) {
                    yaVoto = true
                }
            }
        }
        
        .alert("Confirmar Voto", isPresented: $mostrarConfirmacion) {
            Button("Cancelar", role: .cancel) { }
            Button("Aceptar") {
                ejecutarVoto()
            }
        } message: {
            Text("¿Estás seguro que quieres votar por este candidato?\nRecuerda que solo puedes realizar un voto.")
        }
        
        .alert(mensaje, isPresented: $mostrarAlerta) {
            Button("OK") {
                if mensaje == "¡Voto registrado con éxito!" {
                    tabManager.selectedTab = tabManager.statisticsTabIndex
                    dismiss()
                }
            }
        }
    }
    
    func ejecutarVoto() {
        Task {
            guard let userEmail = fViewModel.user?.email else { return }
            
            votando = true
            do {
                try await api.registrarVoto(
                    candidatoID: candidato.id,
                    firebaseUID: userEmail
                )
                
                mensaje = "¡Voto registrado con éxito!"
                
                let claveUnica = "voto_realizado_\(userEmail)_\(candidato.id)"
                UserDefaults.standard.set(true, forKey: claveUnica)
                
                yaVoto = true
                
            } catch {
                mensaje = "Error: \(error.localizedDescription)"
                
                if let apiError = error as? APIError, case .voteConflict = apiError {
                    let claveUnica = "voto_realizado_\(userEmail)_\(candidato.id)"
                    UserDefaults.standard.set(true, forKey: claveUnica)
                    yaVoto = true
                }
            }
            
            mostrarAlerta = true
            votando = false
        }
    }
}
