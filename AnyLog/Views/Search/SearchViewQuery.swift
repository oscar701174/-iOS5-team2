import SwiftUI
import SwiftData

struct SearchViewQuery: View {
    @EnvironmentObject var dateHolder: DateHolder
    @EnvironmentObject var tabState: TabState
    @Query private var meals: [Meal]
    @Binding var searchText: String
    @Binding var selectedMealTypeList: [MealType]

    
    private var searchTextTrimed: String { searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
    
    var emptyView: some View {
        VStack{
            Spacer()
                Text("식단을 검색해 보세요!")
                    .font(.body)
                    .foregroundStyle(.darkmodeBlack.opacity(0.5))
            Spacer()
        }
    }
    
    var noResultView: some View {
        HStack(alignment: .center) {
            Spacer()
            VStack(alignment:.leading){
                Text("검색 결과가 없습니다.")
                Text("다른 식단을 검색해 보세요!")
            }
            .font(.body)
            .foregroundStyle(.darkmodeBlack.opacity(0.5))
            .padding()
            Spacer()
        }
    }
    
    var filteredByQuery: [Int: [Meal]]? {
    
        let filteredDataByInputText: [Meal] = meals.filter { $0.content.lowercased().contains(searchTextTrimed) }
        let filteredDataByMealType: [Meal] = meals.filter{ selectedMealTypeList.contains($0.mealType)}
    
        guard !filteredDataByInputText.isEmpty || !filteredDataByMealType.isEmpty else { return nil }
        
       if searchText.isEmpty && !selectedMealTypeList.isEmpty {
            
           let unionList: [Meal] = Array(Set(filteredDataByMealType).union(Set(filteredDataByInputText))).sorted(by: {$0.date < $1.date})
               
           if !unionList.isEmpty { return Dictionary(grouping:unionList){$0.date.month} } else { return nil }
           
        } else if !searchText.isEmpty && selectedMealTypeList.isEmpty {
            
            let unionList: [Meal] = Array(Set(filteredDataByMealType).union(Set(filteredDataByInputText))).sorted(by: {$0.date < $1.date})

            if !unionList.isEmpty { return Dictionary(grouping:unionList){$0.date.month} } else { return nil }
            
       } else if !searchText.isEmpty && !selectedMealTypeList.isEmpty {
           
           let intersectedList: [Meal] = Array(Set(filteredDataByMealType).intersection(Set(filteredDataByInputText))).sorted(by: {$0.date < $1.date})

           if !intersectedList.isEmpty { return Dictionary(grouping:intersectedList){$0.date.month}} else { return nil }
           
       } else {
           return nil
       }
    }
    
    var body: some View {
        
        if (searchText.isEmpty && selectedMealTypeList.isEmpty) {
            emptyView
        } else {
            
            VStack {
                
                List {
                    if let filteredByQuery = filteredByQuery {
                        ForEach(filteredByQuery.keys.sorted(by: {$0 > $1}), id:\.self) { month in
                            Section {
                                ForEach(filteredByQuery[month]?.sorted(by:{ $0.time < $1.time } ) ?? [], id: \.persistentModelID){
                                    Databoard(day: String($0.date.day),
                                              mealType: $0.mealType,
                                              meal: $0.content,
                                              time: timeFormat($0.time))
                                }
                            }
                            header: {
                                HStack(spacing:10){
                                    Text("\(month)월")
                                        .font(.title2)
                                        .foregroundStyle(Color(.label))
                                        .onTapGesture {
                                            dateHolder.dateSelected = filteredByQuery[month]?.first?.date ?? Date()
                                            tabState.selected = 1
                                        }
                                    
                                    Button{
                                        withAnimation {
                                            dateHolder.dateSelected = filteredByQuery[month]?.first?.date ?? Date()
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
                    } else {
                        noResultView
                    }
                } //List
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
            } //VStack
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
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
                .frame(maxWidth: 46)
                .foregroundStyle(mealType.color)
                .overlay{
                    Text("\(day)일")
                        .font(.body)
                        .foregroundStyle(Color(.label))
                }
            
            VStack(alignment: .leading){
                Text(mealType.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(.darkmodeBlack)
                Text(meal)
                    .font(.headline).bold()
            }.padding(.horizontal, 10)
            Spacer()
            Text(time).font(.subheadline).foregroundStyle(.secondary)
        }
    }
}

