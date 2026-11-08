import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FBSDKCoreKit

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {

        // Inicializar Firebase
        FirebaseApp.configure()
        print("Firebase configurado correctamente")

        // Configuración de Google Sign-In
        if let clientID = FirebaseApp.app()?.options.clientID {
            GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
            print("Google configurado correctamente con clientID:", clientID)
        } else {
            print("ERROR: No se encontró el clientID en FirebaseApp.options")
        }

        // Inicializar Facebook SDK
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )

        return true
    }

    // Manejo de URLs para Google y Facebook
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        // Manejar Google Sign-in
        if GIDSignIn.sharedInstance.handle(url) {
            return true
        }

        // Manejar Facebook Login
        return ApplicationDelegate.shared.application(app, open: url, options: options)
    }
}

@main
struct PrototipoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject var fViewModel = FirebaseViewModel()
    @StateObject var appState = AppState()
    @StateObject var tabManager = TabStateManager()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(fViewModel)
                .environmentObject(appState)
                .environmentObject(tabManager)
        }
    }
}
