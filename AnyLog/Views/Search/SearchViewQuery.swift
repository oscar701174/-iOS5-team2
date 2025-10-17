import SwiftUI
import SwiftData

struct SearchViewQuery: View {
    @EnvironmentObject var dateHolder: DateHolder
    @EnvironmentObject var tabState: TabState
    @Query private var meals: [Meal]
    @Binding var searchText: String
    @Binding var selectedMealTypeList: [MealType]
    
    var filteredMeals: [Int: [Meal]] {
        let filteredByInputText: [Meal] = meals.filter{$0.content.lowercased().contains(searchText.lowercased())}
        let filteredByMealType: [Meal] = meals.filter{ selectedMealTypeList.contains($0.mealType)}
        
        if(filteredByInputText.isEmpty || filteredByMealType.isEmpty) {
            let unionList: [Meal] = Array(Set(filteredByMealType).union(Set(filteredByInputText))).sorted(by: { $0.date < $1.date })
            return Dictionary(grouping:unionList){$0.date.month}
        }else if(!filteredByInputText.isEmpty && !filteredByMealType.isEmpty){
            let intersectedList: [Meal] = Array(Set(filteredByMealType).intersection(Set(filteredByInputText))).sorted(by: { $0.date < $1.date })
            return Dictionary(grouping:intersectedList){$0.date.month}
        } else {
            return [:]
        }
    }
    
    var mealData = sampleMeals
    var filteredMeals2: [Int: [Meal]] {
        Dictionary(grouping: mealData ){$0.date.month }
    }
    
    var body: some View {
        
        VStack {
            
            List {
                ForEach(filteredMeals.keys.sorted(), id:\.self) { month in
                    Section {
                        ForEach(filteredMeals[month]?.sorted(by:{ $0.time < $1.time } ) ?? [], id: \.id){
                            Databoard(day: String($0.date.day),
                                      mealType: $0.mealType,
                                      meal: $0.content,
                                      time: timeFormat($0.time))
                        }
                        
                    }
                    header: {
                        HStack(spacing:10){
                            Text("\(month)월")
                                .font(.system(size: 25))
                                .foregroundStyle(Color(.label))
                                .onTapGesture {
                                    dateHolder.dateSelected = filteredMeals[month]?.first?.date ?? Date()
                                    tabState.selected = 1
                                }
                            
                            Button{
                                withAnimation {
                                    dateHolder.dateSelected = filteredMeals[month]?.first?.date ?? Date()
                                    tabState.selected = 1
                                }
                            } label:{
                                Image(systemName: "chart.pie.fill")
                                    .resizable()
                                    .frame(maxWidth:20, maxHeight:20)
                                    .foregroundStyle(.darkmodeBlack.opacity(0.7))
                            }
                        } //HStack
                    } //:header
                    
                } // ForEach
            } //List
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            
            
            
            
        } //VStack
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        
    }
}

#Preview {
    SearchViewQuery( searchText: .constant("아몬드"),
                     selectedMealTypeList: .constant(MealType.allCases))
    .modelContainer(for: Meal.self, inMemory: true)
    .environmentObject(DateHolder())
    .environmentObject(TabState())
}



struct Databoard: View {
    let day: String
    let mealType: MealType
    let meal: String
    let time: String
    
    var body: some View {
        HStack(alignment:.top){
            Circle()
                .frame(maxWidth: 37)
                .foregroundStyle(mealType.color)
                .overlay{
                    Text("\(day)일")
                        .font(.system(size: 15))
                        .foregroundStyle(Color(.label))
                }
            
            VStack(alignment: .leading){
                Text(mealType.rawValue)
                    .font(.system(size: 14))
                    .foregroundStyle(.darkmodeBlack)
                Text(meal)
                    .font(.system(size: 16)).bold()
            }.padding(.horizontal, 10)
            Spacer()
            Text(time).font(.system(size: 14))
        }
    }
}



