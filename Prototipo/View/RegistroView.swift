import SwiftUI

struct RegistroView: View {
    @EnvironmentObject var fViewModel: FirebaseViewModel

    @State private var user: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String = ""
    @State private var iniciarSesion = false

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color("Color1"),
                    Color("Color3"),
                    Color("Color3"),
                    Color("Color1")
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {

                Image("log")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)

                // USUARIO
                HStack {
                    Image(systemName: "person")
                        .imagenusuario()

                    TextField(
                        "",
                        text: $user,
                        prompt: Text("USUARIO")
                            .foregroundColor(.white)
                            .font(.system(size: 22))
                    )
                    .padding(.horizontal, 70)
                }
                .usuriodField()

                // CONTRASEÑA
                HStack {
                    Image(systemName: "lock")
                        .imagencontraseña()

                    SecureField(
                        "",
                        text: $password,
                        prompt: Text("CONTRASEÑA")
                            .foregroundColor(.white)
                            .font(.system(size: 22))
                    )
                    .padding(.horizontal, 45)
                }
                .passwordField()

                // CONFIRMAR CONTRASEÑA
                HStack {
                    Image(systemName: "lock")
                        .imagencontraseña()

                    SecureField(
                        "",
                        text: $confirmPassword,
                        prompt: Text("CONFIRMAR CONTRASEÑA")
                            .foregroundColor(.white)
                            .font(.system(size: 22))
                    )
                    .padding(.horizontal, 45)
                }
                .passwordField()

                // MENSAJE DE ERROR
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.yellow)
                        .font(.system(size: 16, weight: .medium))
                }

                // BOTÓN CREAR CUENTA
                Button(action: {
                    crear()
                }) {
                    Text("CREAR CUENTA")
                        .textRegistrate()
                }

                Text("¿Ya tienes una cuenta?")
                    .foregroundStyle(.white)

                Button("Inicia Sesión") {
                    iniciarSesion.toggle()
                }
                .foregroundStyle(.white)
                .padding(.bottom, 100)
                .fullScreenCover(isPresented: $iniciarSesion) {
                    ContentView()
                        .environmentObject(fViewModel)
                }
            }
        }
    }

    // MARK: - FUNCIÓN CREAR CUENTA
    func crear() {
        errorMessage = ""

        guard !user.isEmpty, !password.isEmpty else {
            errorMessage = "Complete los campos"
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Las contraseñas no coinciden"
            return
        }

        fViewModel.createUser(user, password)

        // RootView detecta cambio y navegará automáticamente
    }
}

#Preview {
    RegistroView()
        .environmentObject(FirebaseViewModel())
}

