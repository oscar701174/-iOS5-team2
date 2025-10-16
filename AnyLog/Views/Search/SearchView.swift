

import SwiftUI
import SwiftData

struct SearchView: View {
    @FocusState private var isSearchTextFocused: Bool
    @State private var searchText: String = ""
    @State private var selectedMealTypeList: [MealType] = []
    
    var queryInput: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.gray.opacity(0.2))
            .frame(width: .infinity, height: 36)
            .overlay {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(maxWidth: 20,maxHeight: 20)
                        .padding(.horizontal,10)
                        .foregroundStyle(.secondary)
                    TextField("Search", text: $searchText)
                        .font(.system(size: 14))
                        .focused($isSearchTextFocused)
                        .onAppear {
                            isSearchTextFocused = true
                        }
                        .onSubmit {
                            isSearchTextFocused = false
                        }
                }
            }
    }
    
    var queryButton: some View {
        HStack{
            ForEach(MealType.allCases) { mealType in
                // TODO: 선택된 mealType이 있다면 buttonStyle 변경
                Button{
                    if isSelected(mealType) {
                        selectedMealTypeList.removeAll { element in
                            element == mealType
                        }
                    } else {
                        selectedMealTypeList.append(mealType)
                    }
                } label: {
                    Text(mealType.rawValue)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(isSelected(mealType) ? .darkmodeBlack.opacity(0.7) : .darkmodeBlack.opacity(0.3))
                        
                }
                .frame(maxWidth: 50 , maxHeight: 30)
                .background(isSelected(mealType) ? mealType.color.opacity(0.5) : .darkmodeBlack.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .modifier(ConditionalGlassEffect(apply: isSelected(mealType)))
            
            }
        }
    }
    
    var body: some View {
        VStack{
            VStack(alignment:.leading,spacing: 20) {
                queryInput.padding(.top, 20)
                queryButton
            }.padding(.horizontal, 20)
            
            SearchViewQuery(searchText: $searchText, selectedMealTypeList: $selectedMealTypeList)
    
  
        }
        
    }
    
    func isSelected(_ mealType :MealType) -> Bool {
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

// Helper view modifier to conditionally apply glassEffect(.clear)
private struct ConditionalGlassEffect: ViewModifier {
    let apply: Bool
    func body(content: Content) -> some View {
        if apply {
            content.glassEffect(.clear)
        } else {
            content
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




