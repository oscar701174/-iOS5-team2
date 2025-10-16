

import SwiftUI
import SwiftData

struct SearchView: View {
    @FocusState private var isSearchTextFocused: Bool

    @State private var searchText: String = ""
    @State private var selectedMealTypeList: [MealType] = []
    
    var queryInput: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.darkmodeBlack.opacity(0.1))
            .frame(maxWidth: .infinity, maxHeight: 36)
            .overlay {
                HStack {
                    // Use a fixed size to avoid invalid frame dimensions
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 16, weight: .regular)) // sizes the SF Symbol safely
                        .frame(maxWidth: 20, maxHeight: 20, alignment: .center)
                        .padding(.horizontal,10)
                    
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
            Text("검색 페이지").font(.system(size: 20, weight: .bold)).padding(.top,20)
            VStack(alignment:.leading,spacing: 20) {
 
                queryInput.padding(.top, 10)
                
                queryButton
            }.padding(.horizontal, 20)
            
            SearchViewQuery(searchText: $searchText, selectedMealTypeList: $selectedMealTypeList)
                .padding(.top,15)
        }
        
    }
    
    func isSelected(_ mealType :MealType) -> Bool {
        return selectedMealTypeList.contains(mealType)
    }
    
}

#Preview {
    SearchView()
}


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





