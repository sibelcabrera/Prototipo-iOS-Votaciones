import Foundation
@MainActor
class PerfilUserViewModel: ObservableObject {
    private let firebase = FirebaseModel()
    @Published var didLogout = false   // Para regresar a la pantalla de login
    
    func logOut() {
        do {
            try firebase.logOutUser()
            didLogout = true
        } catch {
            print("Error al cerrar sesión: \(error.localizedDescription)")
        }
    }
}

