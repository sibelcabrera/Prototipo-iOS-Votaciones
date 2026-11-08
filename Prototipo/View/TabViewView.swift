import SwiftUI

struct TabViewView: View {
    @EnvironmentObject var fViewModel: FirebaseViewModel
    @EnvironmentObject var tabManager: TabStateManager
    
    var body: some View {
        TabView(selection: $tabManager.selectedTab) {
            
            NavigationStack {
                HomeView()
            }
            .tag(0)
            .tabItem {
                Image(systemName: "house.fill")
            }
            
            CalendarView()
                .tag(1)
                .tabItem {
                    Image(systemName: "calendar.badge.plus")
                }
            
            EstadisticaVistaView()
                .tag(2)
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                }
            
            ConsultasView()
                .tag(3)
                .tabItem {
                    Image(systemName: "questionmark.circle")
                }
            
            NavigationView {
                PerfilUserView()
            }
            .tag(4)
            .tabItem {
                Image(systemName: "person.circle")
            }
        }
    }
}
