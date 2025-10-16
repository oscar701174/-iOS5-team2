

import SwiftUI
import SwiftData

struct SearchView: View {
    @Query(sort: [SortDescriptor(\Meal.date, order: .reverse)]) private var meals: [Meal]
    @State var searchText: String = ""
    @State var selectedMealTypeList: [MealType] = []
    


    
    var body: some View {
        VStack {
            
            
            
            RoundedRectangle(cornerRadius: 8)
                .fill(.gray.opacity(0.2))
                .frame(width: .infinity, height: 36)
                .overlay {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 20,height: 20)
                            .padding(.leading)
                            .foregroundStyle(.secondary)
                        TextField("Search", text: $searchText) {
                            
                        }
                    }
                }
                .padding(20)
            
            HStack {
                ForEach(MealType.allCases) { mealType in
                    // TODO: 선택된 mealType이 있다면 buttonStyle 변경
                    Button(mealType.rawValue) {
                        if isSelectedMealType(mealType) {
                            selectedMealTypeList.removeAll { element in
                                element == mealType
                            }
                        } else {
                            selectedMealTypeList.append(mealType)
                        }
                    }
                    .buttonStyle(.bordered)
                    .tint(.main)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            ForEach(meals) {
                Text($0.mealType.rawValue)
            }
            
            
            if searchText.isEmpty {
                
                NeedSearchView()
            } else {
                
            }
        }
        
    }
    
    func isSelectedMealType(_ mealType :MealType) -> Bool {
        return selectedMealTypeList.contains(mealType)
    }
    
}

#Preview {
    SearchView()
}


struct NeedSearchView: View {
    var body: some View {
        VStack {
            
            
            Spacer()
            
            Text("검색하고 싶은 식단을 입력하세요.")
            
            Spacer()
        }
    }
}

//extension View {
//    func `if`<Content: View>(_ conditional: Bool, apply: (Self) -> Content) -> some View {
//        if conditional {
//            return AnyView(apply(self))
//        } else {
//            return AnyView(self)
//        }
//    }
//}
