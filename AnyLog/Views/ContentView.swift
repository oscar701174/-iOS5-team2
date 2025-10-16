
import SwiftUI
import SwiftData

struct ContentView: View {
 
    @Environment(\.modelContext) private var context
    var body: some View {
        TabView {
            HomeView()
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
            insertSampleData()
        }
        
    }
    
    private func insertSampleData() {
        let sampleMeals: [Meal] = [
            Meal(mealType: .breakfast,
                 content: "토스트와 커피",
                 date: Date(year: 2025, month: 10, day: 14),
                 time: Date(year: 2025, month: 10, day: 14, hour: 8, minute: 15)),
            
            Meal(mealType: .breakfast,
                 content: "닭가슴살 샐러드와 고구마",
                 date: Date(year: 2025, month: 10, day: 14),
                 time: Date(year: 2025, month: 10, day: 14, hour: 12, minute: 45)),
            
            Meal(mealType: .dinner,
                 content: "된장찌개, 밥, 김치",
                 date: Date(year: 2025, month: 10, day: 14),
                 time: Date(year: 2025, month: 10, day: 10, hour: 19, minute: 30)),
            
            Meal(mealType: .snack,
                 content: "요거트와 블루베리",
                 date: Date(year: 2025, month: 10, day: 14),
                 time: Date(year: 2025, month: 10, day: 10, hour: 16, minute: 0)),
            
            Meal(mealType: .dinner,
                 content: "오트밀과 바나나",
                 date: Date(year: 2025, month: 10, day: 11),
                 time: Date(year: 2025, month: 10, day: 11, hour: 7, minute: 50)),
            
            Meal(mealType: .lunch,
                 content: "비빔밥과 미역국",
                 date: Date(year: 2025, month: 10, day: 11),
                 time: Date(year: 2025, month: 10, day: 11, hour: 13, minute: 10)),
            
            Meal(mealType: .dinner,
                 content: "연어 스테이크와 구운 채소",
                 date: Date(year: 2025, month: 10, day: 11),
                 time: Date(year: 2025, month: 10, day: 11, hour: 18, minute: 50)),
            
            Meal(mealType: .snack,
                 content: "아몬드 한 줌",
                 date: Date(year: 2025, month: 11, day: 11),
                 time: Date(year: 2025, month: 10, day: 11, hour: 15, minute: 30)),
            
            Meal(mealType: .breakfast,
                 content: "스크램블에그와 오렌지 주스",
                 date: Date(year: 2025, month: 11, day: 12),
                 time: Date(year: 2025, month: 10, day: 12, hour: 8, minute: 5)),
            
            Meal(mealType: .dinner,
                 content: "파스타와 샐러드",
                 date: Date(year: 2025, month: 10, day: 12),
                 time: Date(year: 2025, month: 10, day: 12, hour: 19, minute: 20))
        ]


            for meal in sampleMeals {
                context.insert(meal)
            }

            do {
                try context.save()
                print("✅ Sample data inserted")
            } catch {
                print("❌ Failed to insert sample data: \(error)")
            }
        }
    
    
}


#Preview {
    
    let container = try! ModelContainer(
        for: Meal.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let context = container.mainContext
    
    for meal in sampleMeals {
        context.insert(meal)
    }
    
    
    return ContentView()
            .modelContainer(for: Meal.self, inMemory: true)

}


