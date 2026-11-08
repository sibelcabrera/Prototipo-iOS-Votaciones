import SwiftUI

struct RestPasswordView: View {
    // Estados locales para almacenar la entrada del usuario
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            
           
            Form {
                Text("Aqui podras cambiar tu contraseña actual y define una nueva.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)

                
                Section(header: Text("SEGURIDAD DE LA CUENTA")) {
                    
                    // 1. Contraseña Actual
                    SecureField("Contraseña Actual", text: $currentPassword)
                        .textContentType(.password)
                    
                    // 2. Nueva Contraseña
                    SecureField("Nueva Contraseña", text: $newPassword)
                        .textContentType(.newPassword)
                    
                    // 3. Confirmar Nueva Contraseña
                    SecureField("Confirmar Nueva Contraseña", text: $confirmPassword)
                        .textContentType(.newPassword)
                }
            }
            
            .navigationTitle("Cambiar Contraseña")
            .navigationBarTitleDisplayMode(.inline)

           
            Button(action: {
                changePassword()
            }) {
                Text("GUARDAR CONTRASEÑA")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 25)
            .padding(.top, 10)
            .padding(.bottom, 100)
        }
    }

    // Función que se ejecuta al presionar el botón
    func changePassword() {
        // Validación básica de campos
        guard !currentPassword.isEmpty, !newPassword.isEmpty, !confirmPassword.isEmpty else {
            print("Error: Todos los campos deben estar llenos.")
            return
        }

        // Verificar que la nueva contraseña y la confirmación coincidan
        guard newPassword == confirmPassword else {
            print("Error: La nueva contraseña y la confirmación no coinciden.")
            return
        }
    
        print("Intentando cambiar la contraseña...")
        print("Contraseña actual enviada: \(currentPassword.prefix(1))***")
        print("Nueva contraseña lista para guardar.")

        dismiss() // Cierra la vista
    }
}

// ----------------------------------------------------

#Preview {
    NavigationView {
        RestPasswordView()
    }
}
