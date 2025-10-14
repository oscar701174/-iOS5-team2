
import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
                
            
            StatisticsView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("통계")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
        }
        .onAppear {
            UITabBar.appearance().scrollEdgeAppearance = .init()
        }
        
    }
}

   

#Preview {
    ContentView()
        .modelContainer(for: Meal.self, inMemory: true)
}
