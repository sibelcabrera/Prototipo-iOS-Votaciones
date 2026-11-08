import Foundation
import GoogleSignIn
import FBSDKLoginKit
import FirebaseAuth

public class FirebaseViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var messageError: String?
    private let rFirebaseModel: RepositorioFirebaseModel
    
    init(rFirebaseModel: RepositorioFirebaseModel = RepositorioFirebaseModel()) {
        self.rFirebaseModel = rFirebaseModel
    }
    
    func start() {
        getUser()
    }

    func getUser() {
        self.user = rFirebaseModel.getUser()
    }
    
    func createUser(_ email: String, _ password: String) {
        rFirebaseModel.createUser(email: email, password: password) { [weak self] data in
            switch data {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    func loginUser(_ email: String, _ password: String) {
        rFirebaseModel.loginUser(email: email, password: password) { [weak self] data in
            switch data {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    func logOutUser() {
        do {
            try rFirebaseModel.logOutUser()
            self.user = nil
        } catch {
            print("Error al deslogearse \(error.localizedDescription)")
        }
    }
}




extension FirebaseViewModel {

    //LOGIN GOOGLE
    func loginWithGoogle(presenting: UIViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { [weak self] result, error in

            if let error = error {
                self?.messageError = error.localizedDescription
                return
            }

            guard let idToken = result?.user.idToken?.tokenString,
                  let accessToken = result?.user.accessToken.tokenString else {
                self?.messageError = "No se pudo obtener token de Google"
                return
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: accessToken
            )

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self?.messageError = error.localizedDescription
                    return
                }

                self?.user = UserModel(
                    email: authResult?.user.email ?? ""
                )

            }
        }
    }


    // LOGIN FACEBOOK

}
