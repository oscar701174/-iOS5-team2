

import SwiftUI
import Charts

struct GraphBarMark: View {
    @EnvironmentObject var dateHolder: DateHolder
    var mealDataGroupedByMonth:[Meal] {sampleMeals.filter { $0.date.yearMonth == dateHolder.dateSelected.yearMonth}.sorted(by: { $0.time.hour < $1.time.hour })}
    private var mealGraphData:[MealGraphDataV2] {
        var mealDataGroupedByHour:[MealGraphDataV2] = [ ]
        let sumByMealType: [MealType:Int] = mealDataGroupedByMonth.reduce(into: [MealType: Int]()) { $0[$1.mealType, default: 0] += 1 }
        mealDataGroupedByMonth.forEach { meal in
           let mealData: MealGraphDataV2 = MealGraphDataV2(hour: meal.time.hour, mealType: meal.mealType, total: sumByMealType[meal.mealType] ?? 0 )
            mealDataGroupedByHour.append(mealData)
        }
        return mealDataGroupedByHour
    }
    
    
    var body: some View {
        VStack{
            Chart(mealGraphData) {
                BarMark(
                    x: .value("Hour", $0.hour),
                    y: .value("Total", $0.total)
                )
                .foregroundStyle($0.mealType.color)
            } //Chart
    
        } // VStack
        .padding()
    } // body
}

#Preview {
    GraphBarMark()
        .environmentObject(DateHolder())
}


struct MealGraphDataV2: Identifiable,Hashable {
    let id: UUID = UUID()
    let hour: Int
    let mealType: MealType
    let total: Int
}


let sampleMeals2: [Meal] = [
    Meal(mealType: .breakfast,
         content: "토스트와 커피",
         date: Date(year: 2025, month: 10, day: 15),
         time: Date(year: 2025, month: 10, day: 15, hour: 8, minute: 15)),
    
    Meal(mealType: .breakfast,
         content: "닭가슴살 샐러드와 고구마",
         date: Date(year: 2025, month: 10, day: 15),
         time: Date(year: 2025, month: 10, day: 15, hour: 12, minute: 45)),
    
    Meal(mealType: .dinner,
         content: "된장찌개, 밥, 김치",
         date: Date(year: 2025, month: 10, day: 15),
         time: Date(year: 2025, month: 10, day: 15, hour: 19, minute: 30)),
    
    Meal(mealType: .snack,
         content: "요거트와 블루베리",
         date: Date(year: 2025, month: 10, day: 14),
         time: Date(year: 2025, month: 10, day: 15, hour: 16, minute: 0)),
    
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
