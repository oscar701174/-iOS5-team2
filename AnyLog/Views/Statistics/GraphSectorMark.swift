import SwiftUI
import SwiftData
import Charts

struct GraphSectorMark: View {
    @EnvironmentObject var dateHolder: DateHolder
    @Query private var meals: [Meal]
    var mealDataGroupedByMonth:[Meal] {meals.filter { $0.date.yearMonth == dateHolder.dateSelected.yearMonth}}
    private var mealGraphData:[(mealType: MealType, total:Int, ratio: Double)] {
        let sumByMealType: [MealType: Int] = mealDataGroupedByMonth.reduce(into: [MealType: Int]()) { $0[$1.mealType, default: 0] += 1 }
        return sumByMealType.map{(mealType: $0.key, total: $0.value, ratio: Double($0.value)/Double(mealDataGroupedByMonth.count))}
    }
    
    var body: some View {
        VStack {
      
                Chart(mealGraphData.sorted(by:{ $0.mealType.num < $1.mealType.num }), id: \.mealType) { mealType, total, ratio in
                    SectorMark ( angle: .value("Meal Count" , total), innerRadius: .ratio(0.55), outerRadius: .inset(10), angularInset: 3.0 )
                        .cornerRadius(10)
                        .foregroundStyle(mealType.color)
                        .annotation(position: .overlay, alignment: .centerFirstTextBaseline) {
                            Text("\(String(format: "%.1f", ratio * 100))%")
                                .font(Font.system(size: 12))
                                .foregroundStyle(.primary)
                                .padding(8)
                                .background(Capsule()
                                    .fill(.ultraThinMaterial)
                                    .glassEffect(.clear))
                            
                        }
                }.frame(minWidth: 270,maxWidth:400, minHeight: 270,maxHeight: 400)
                    .padding(.top,20)
                
                VStack {
                    ForEach(mealGraphData.sorted(by:{ $0.mealType.num < $1.mealType.num }), id:\.mealType) { mealType, total, ratio in
                        HStack {
                            Circle()
                                .fill(mealType.color)
                                .frame(width: 10, height: 10)
                            Text(mealType.rawValue)
                                .font(.system(size: 15))
                                .foregroundStyle(.primary)
                            Spacer()
                            Text("\(String(format: "%.1f", ratio * 100))%")
                                .font(Font.system(size: 15))
                                .foregroundStyle(.darkmodeBlack)
                        } // HStackgg
                    } // ForEach
                }.padding(.horizontal,15)
             
                    
         
            
        }.padding(.horizontal,10) //VStacks
   
        
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

