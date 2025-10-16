import SwiftUI
import SwiftData

struct SearchViewQuery: View {
    @Query private var meals: [Meal]
    @Binding var searchText: String
    @Binding var selectedMealTypeList: [MealType]
    @State private var stack = NavigationPath()
    
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
    var filteredMeals2 :[Int: [Meal]] {
        Dictionary(grouping: mealData ){$0.date.month }
    }
    
    var body: some View {
        
        VStack {
            List {
                ForEach(filteredMeals.keys.sorted(), id:\.self) { month in
                    Section {
                        
                        ForEach(filteredMeals[month] ?? [], id: \.id){
                            Databoard(day: String($0.date.day),
                                      mealType: $0.mealType,
                                      meal: $0.content,
                                      time: timeForamt($0.time))
                        }
    
                    }
                    header: {
                            Text("\(month)월")
                                .font(.system(size: 25))
                                .foregroundStyle(Color(.label))
                    }
                    
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



