import SwiftUI
import SwiftData
import Charts

struct GraphSectorMark: View {
    @EnvironmentObject var dateHolder: DateHolder
    var mealDataGroupedByMonth:[Meal] {sampleMeals.filter { $0.date.yearMonth == dateHolder.dateSelected.yearMonth}}
    private var mealGraphData:[(mealType: MealType, total:Int, ratio: Double)] {
        let sumByMealType: [MealType: Int] = mealDataGroupedByMonth.reduce(into: [MealType: Int]()) { $0[$1.mealType, default: 0] += 1 }
        return sumByMealType.map{(mealType: $0.key, total: $0.value, ratio: Double($0.value)/Double(mealDataGroupedByMonth.count))}
    }
    
    var body: some View {
        VStack {
            
            Chart(mealGraphData, id: \.mealType) { mealType, total, ratio in
                SectorMark ( angle: .value("Meal Count" , total), innerRadius: .ratio(0.55), outerRadius: .inset(10), angularInset: 3.0 )
                    .cornerRadius(10).foregroundStyle(mealType.color)
                    .annotation(position: .overlay, alignment: .centerFirstTextBaseline) {
                        Text("\(String(format: "%.1f", ratio * 100))%")
                            .font(Font.system(size: 12)).foregroundStyle(.primary).padding(8)
                            .background(Capsule().fill(.ultraThinMaterial)  .glassEffect(.clear))
                         
                    }
            }
            
            VStack {
                ForEach(mealGraphData.sorted(by:{ $0.mealType.num < $1.mealType.num }), id:\.mealType) { mealType, total, ratio in
                    HStack {
                        Circle()
                            .fill(mealType.color)
                            .frame(width: 10, height: 10)
                        Text(mealType.rawValue).font(.system(size: 15)).foregroundStyle(.primary)
                        Spacer()
                        Text("\(String(format: "%.1f", ratio * 100))%").font(Font.system(size: 15)).foregroundStyle(.primary)
                    } // HStackgg
                } // ForEach
            }.padding(.horizontal,15)
            
        }.padding() //VStacks
        .frame(maxWidth: 400,maxHeight:.infinity)
        
    } // body
}

#Preview {
    GraphSectorMark()
        .environmentObject(DateHolder())
}

// Keep this as a plain extension; no stored properties.
extension MealType{
    
    var num: Int {
        switch self {
            case .breakfast : return 1
            case .lunch : return 2
            case .dinner : return 3
            case .snack : return 4
        }
    }
    
    var color: Color {
        switch self {
        case .breakfast: return .breakfast
        case .lunch: return .lunch
        case .dinner: return .dinner
        case .snack: return .snack
        }
    }
}

/*
 // If you ever need Identifiable, use a computed id (no stored properties in extensions).
 extension MealType: Identifiable {
 var id: String { self.rawValue }
 }
 */

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

