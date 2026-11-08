import SwiftUI

struct ContentView: View {
    @EnvironmentObject var fViewModel: FirebaseViewModel
    @State private var user: String = ""
    @State private var password: String = ""
    @State private var registrate: Bool = false

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

                // BOTÓN INGRESA
                Button(action: {
                    fViewModel.loginUser(user, password)
                }) {
                    Text("INGRESA")
                        .textIngresa()
                }

                // GOOGLE LOGIN
                Button(action: {
                    if let controller = UIApplication.shared.topViewController() {
                        fViewModel.loginWithGoogle(presenting: controller)
                    }
                }) {
                    HStack {
                        Image("google").imagengoogle()
                        Text("Google")
                    }
                    .botongoogle()
                }

                // FACEBOOK LOGIN
             


                Text("No tiene una cuenta ?")
                    .foregroundStyle(.white)

                Button(action: {
                    registrate.toggle()
                }) {
                    Text("REGISTRATE")
                        .botonRegistrate()
                }
                .padding(.bottom, 100)
                .fullScreenCover(isPresented: $registrate) {
                    RegistroView()
                        .environmentObject(fViewModel)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FirebaseViewModel())
}

