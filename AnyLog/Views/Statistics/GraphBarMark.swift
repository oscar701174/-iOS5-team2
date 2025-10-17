

import SwiftUI
import Charts
import SwiftData

struct GraphBarMark: View {

    @EnvironmentObject var dateHolder: DateHolder
    @Query(sort: [SortDescriptor(\Meal.date, order: .reverse)]) private var meals: [Meal]
    var mealDataGroupedByMonth:[Meal] {meals.filter { $0.date.yearMonth == dateHolder.dateSelected.yearMonth}.sorted(by: { $0.time.hour < $1.time.hour })}
    private var mealGraphData:[MealDataByHour] {
        let sumByMealHour: [Int:Int] = mealDataGroupedByMonth.reduce(into: [Int: Int]()) { $0[$1.time.hour, default: 0] += 1 }
        return sumByMealHour.keys.sorted().map{MealDataByHour(hour: String($0), total: sumByMealHour[$0] ?? 0, monthTotal: mealDataGroupedByMonth.count) }
    }

    var body: some View {
        VStack{
                Chart(mealGraphData) { data in
                    BarMark( x: .value("Hour", "\(data.hour)시"), y: .value("Total", data.total) )
                        .cornerRadius(10)
                        .annotation(position: .overlay, alignment: .top){
                            Text(String(data.total)).font(Font.system(size: 12))
                                .foregroundStyle(.primary)
                                .padding(8)
                                .background(Circle()
                                    .fill(.ultraThinMaterial))
                        }
                } //Chart
                .chartXAxis{
                    AxisMarks {
                        AxisTick()
                        AxisValueLabel()
                            .font(.system(size: 12))
                            .foregroundStyle(.darkmodeWhite.opacity(0.7))
                    }
                }
                .chartYAxis(.hidden)
                .frame(maxWidth:400,maxHeight: 300)

          
        } // VStack
        .padding(.horizontal,10)

  
    } // body
}

#Preview {
    GraphBarMark()
        .environmentObject(DateHolder())
}


struct MealDataByHour: Identifiable,Hashable {
    let id: UUID = UUID()
    let hour: String
    let total: Int
    let monthTotal: Int
}

