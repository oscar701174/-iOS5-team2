import SwiftUI
import SwiftData

struct SearchViewQuery: View {
    // Make the query dynamic by referencing the state it depends on.
    @Query private var meals: [Meal]
    @Binding var searchText: String
    @Binding var selectedMealTypeList: [MealType]
    
    var filteredMeals: [Meal]? {
        let filteredByInputText: [Meal] = meals.filter{$0.content.contains(searchText.lowercased())}
        let filteredByMealType: [Meal] = meals.filter{ selectedMealTypeList.contains($0.mealType)}
        
        if(filteredByInputText.isEmpty || filteredByMealType.isEmpty) {
            let unionList: [Meal] = Array(Set(filteredByMealType).union(Set(filteredByInputText))).sorted(by: { $0.date < $1.date })
            return unionList
        }else if(!filteredByInputText.isEmpty && !filteredByMealType.isEmpty){
            
            let intersectedList: [Meal] = Array(Set(filteredByMealType).intersection(Set(filteredByInputText))).sorted(by: { $0.date < $1.date })
            return intersectedList
        } else {
            return nil
        }
    }
    
    var body: some View {
        VStack {
        
                ForEach(filteredMeals ?? []) { meal in
                    
                    Text(meal.content)
                }
            
        
        }
        // No reassignment of _meals here.
    }
}

#Preview {
    SearchViewQuery(searchText: .constant("아몬드"), selectedMealTypeList: .constant(MealType.allCases))
        .modelContainer(for: Meal.self, inMemory: true)
}
