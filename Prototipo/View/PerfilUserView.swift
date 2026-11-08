import SwiftUI

struct PerfilUserView: View {
    
    @EnvironmentObject var fViewModel: FirebaseViewModel
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                // Fondo superior con degradado
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 30/255, green: 55/255, blue: 119/255),
                                Color(red: 58/255, green: 95/255, blue: 233/255)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(height: 200)
                    
                    Color(uiColor: .systemGray6)
                }
                .edgesIgnoringSafeArea(.top)
                
                // Contenido principal
                ScrollView {
                    VStack(spacing: 25) {
                        
                        // FOTO Y DATOS DEL USUARIO
                        VStack(spacing: 6) {
                            Image("perfil_mujer")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 180, height: 180)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 5)
                            
                            // Correo del usuario conectado
                            Text(fViewModel.user?.email ?? "Usuario")
                                .font(.title2.bold())
                            
                            Text("Usuario Activo")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.bottom, 20)
                        }
                        .padding(.top, 50)
                        
                        // BLOQUE DE ACCIONES PRINCIPALES
                        VStack(spacing: 0) {
                            
                            // Editar Perfil
                            NavigationLink(destination: EditarPerfilView()) {
                                PerfilItemView(icon: "person.crop.circle.badge.plus", text: "Editar Perfil")
                                    .padding()
                            }
                            .buttonStyle(.plain)
                            Divider().padding(.leading, 16)
                            
                            // Cambiar Contraseña
                            NavigationLink(destination: RestPasswordView()) {
                                PerfilItemView(icon: "ellipsis.bubble", text: "Cambiar de contraseña")
                                    .padding()
                            }
                            .buttonStyle(.plain)
                            Divider().padding(.leading, 16)
                            
                            // Botón Cerrar Sesión
                            Button {
                                fViewModel.logOutUser()
                            } label: {
                                PerfilItemView(icon: "arrow.right.square", text: "Cerrar Sesión", showChevron: false)
                                    .padding()
                            }
                            .buttonStyle(.plain)
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .shadow(color: .black.opacity(0.1), radius: 5, y: 2)
                        
                        // BLOQUE INFERIOR (Legales)
                        VStack(spacing: 0) {
                            
                            // Header (Con truco de navegación opcional a NosotrosView)
                            HStack {
                                Text("SOBRE NOSOTROS")
                                    .font(.headline)
                                Spacer()
                            }
                            .padding()
                            .background(
                                NavigationLink("", destination: NosotrosView())
                                    .opacity(0)
                            )
                            Divider().padding(.leading, 16)
                            
                            // Condiciones de Servicio
                            NavigationLink(destination: CondicionesView()) {
                                HStack {
                                    Text("CONDICIONES DE SERVICIO")
                                    Spacer()
                                    Image(systemName: "chevron.right").foregroundColor(.gray)
                                }
                                .padding()
                            }
                            .buttonStyle(.plain)
                            Divider().padding(.leading, 16)
                            
                            // Términos del Acuerdo
                            NavigationLink(destination: TerminosView()) {
                                HStack {
                                    Text("TÉRMINOS DEL ACUERDO")
                                    Spacer()
                                    Image(systemName: "chevron.right").foregroundColor(.gray)
                                }
                                .padding()
                            }
                            .buttonStyle(.plain)
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .shadow(color: .black.opacity(0.1), radius: 5, y: 2)
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

// --- SUBVISTA PARA LAS FILAS ---
struct PerfilItemView: View {
    let icon: String
    let text: String
    var showChevron: Bool = true
    
    var body: some View {
        HStack(spacing: 15) {
            // Icono con fondo
            ZStack {
                Color.blue.opacity(0.1)
                    .frame(width: 40, height: 40)
                    .cornerRadius(10)
                
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
            }
            
            // Texto
            Text(text)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            // Flecha condicional
            if showChevron {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            }
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    PerfilUserView()
        .environmentObject(FirebaseViewModel())
}
