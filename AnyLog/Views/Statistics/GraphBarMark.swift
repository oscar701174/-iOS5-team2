

import SwiftUI
import Charts
import SwiftData


struct GraphBarMark: View {

    @EnvironmentObject var dateHolder: DateHolder
    @Query(sort: [SortDescriptor(\Meal.date, order: .reverse)]) private var meals: [Meal]
    // dateHolder에 있는 dateSeleted 값을 기반으로 데이터 swiftData의 Data filtering
//    var meals = sampleMeals
    var mealDataGroupedByMonth:[Meal] {meals.filter { $0.date.yearMonth == dateHolder.dateSelected.yearMonth}.sorted(by: { $0.time.hour < $1.time.hour })}
    private var mealGraphData:[MealDataByHour] {
        // 시간별 합산해서 dic타입으로 변환
        let sumByMealHour: [Int:Int] = mealDataGroupedByMonth.reduce(into: [Int: Int]()) { $0[$1.time.hour, default: 0] += 1 }
        // sumByMealHour을 시간별 정렬 > mealGraphData 리스트 변환
        return sumByMealHour.keys.sorted().map{MealDataByHour(hour: String($0), total: sumByMealHour[$0] ?? 0, monthTotal: mealDataGroupedByMonth.count) }
    }

    var body: some View {
        VStack{
            Chart(mealGraphData, id:\.id) { data in
                    BarMark( x: .value("Hour", "\(data.hour)시"), y: .value("Total", data.total) )
                        .cornerRadius(10)
                        .annotation(position: .top, alignment: .center) {

                            Text(String(data.total))
                                    .font(.caption)
                                    .foregroundStyle(.primary)
                                    .padding(8)
                                    .background(.darkmodeBlack.opacity(0.2))
                                    .clipShape(Circle())
                        }
                } //Chart
                .chartXAxis{
                    AxisMarks {
                        AxisTick()
                        AxisValueLabel()
                            .font(.footnote)
                            .foregroundStyle(.darkmodeBlack.opacity(0.6))
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



