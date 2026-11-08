import SwiftUI

struct RootView: View {
    @State private var showSplash = true
    @EnvironmentObject var fViewModel: FirebaseViewModel
    @EnvironmentObject var appState: AppState

    var body: some View {

        ZStack {
            if showSplash {
                
                LogoView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                showSplash = false
                                fViewModel.start()   // ← INICIA SESIÓN AUTOMÁTICA AQUÍ
                            }
                        }
                    }

            } else {

                if fViewModel.user != nil {
                    TabViewView()
                } else {
                    ContentView()
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(FirebaseViewModel())
            .environmentObject(AppState())
    }
}

