
import SwiftUI
import SwiftData

struct ContentView: View {

    @EnvironmentObject var dateHolder: DateHolder
    @Environment(\.modelContext) var modelContext
    
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
            // 하위 OS버전 TabView 색상 대응
            UITabBar.appearance().scrollEdgeAppearance = .init()

//             테스트 데이터 SwiftData에 넣기
            addTestData()

        }
        
        
    }
    
    func addTestData() {
        let sampleMeals2: [Meal] = [
            Meal(mealType: .breakfast,
                 content: "Toast 와 커피",
                 date: Date(year: 2025, month: 10, day: 15),
                 time: Date(year:   2025, month: 10, day: 15, hour: 7, minute: 15)),
            
            Meal(mealType: .lunch,
                 content: "닭가슴살 샐러드와 coffee",
                 date: Date(year: 2025, month: 10, day: 15),
                 time: Date(year: 2025, month: 10, day: 15, hour: 12, minute: 25)),
            
            Meal(mealType: .dinner,
                 content: "된장찌개, 밥, 김치",
                 date: Date(year: 2025, month: 10, day: 15),
                 time: Date(year: 2025, month: 10, day: 15, hour: 19, minute: 30)),
            
            Meal(mealType: .snack,
                 content: "요거트와 블루베리",
                 date: Date(year: 2025, month: 10, day: 15),
                 time: Date(year: 2025, month: 10, day: 15, hour: 16, minute: 0)),
            
            Meal(mealType: .breakfast,
                 content: "오트밀과 바나나",
                 date: Date(year: 2025, month: 10, day: 14),
                 time: Date(year: 2025, month: 10, day: 14, hour: 7, minute: 50)),
            
            Meal(mealType: .lunch,
                 content: "비빔밥과 미역국",
                 date: Date(year: 2025, month: 10, day: 14),
                 time: Date(year: 2025, month: 10, day: 14, hour: 13, minute: 10)),
            
            Meal(mealType: .dinner,
                 content: "연어 스테이크와 구운 채소",
                 date: Date(year: 2025, month: 10, day: 14),
                 time: Date(year: 2025, month: 10, day: 14, hour: 18, minute: 50)),
            
            Meal(mealType: .snack,
                 content: "아몬드 한 줌",
                 date: Date(year: 2025, month: 10, day: 14),
                 time: Date(year: 2025, month: 10, day: 14, hour: 15, minute: 30)),
            
            Meal(mealType: .breakfast,
                 content: "스크램블에그와 오렌지 주스",
                 date: Date(year: 2025, month: 10, day: 13),
                 time: Date(year: 2025, month: 10, day: 13, hour: 8, minute: 5)),
            
            Meal(mealType: .dinner,
                 content: "파스타와 샐러드",
                 date: Date(year: 2025, month: 10, day: 13),
                 time: Date(year: 2025, month: 10, day: 13, hour: 19, minute: 20))
        ]

        for meal in sampleMeals2 {
            modelContext.insert(meal)
        }
        
        try? modelContext.save()
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
            .modelContainer(container)
            .environmentObject(DateHolder())

}


