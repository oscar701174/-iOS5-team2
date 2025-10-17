import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var selectedDate = Date()
    @State private var isComposePresented: Bool = false
    @State private var selectedMeal: Meal? = nil
    
    @Environment(\.colorScheme) var colorScheme
    
    @Environment(\.modelContext) private var context
    
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Environment(\.verticalSizeClass) private var vSizeClass
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let meal = mealsForSelectedDate[index]
            context.delete(meal)
        }
        try? context.save()
    }
    
    
    @Query(sort: [SortDescriptor(\Meal.date, order: .reverse)])
    var meals: [Meal]
    
    @State var showComoser: Bool = false
    @State var keyword: String = ""
    
    // 선택된 날짜의 식단만 필터링해서 시간순 정렬
    var mealsForSelectedDate: [Meal] {
        meals.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
            .sorted { $0.time < $1.time }
    }
    
    var mealTyep: [Meal] {
        if keyword.isEmpty {
            return meals
        } else {
            return meals.filter {
                return $0.content.lowercased().contains(keyword.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if hSizeClass == .regular {
                    GeometryReader { proxy in
                        let isLandscape = proxy.size.width > proxy.size.height
                        if isLandscape {
                            // Landscape: two grouped columns centered
                            let _: CGFloat = 400
                            let _: CGFloat = 560
                            
                                VStack(alignment: .leading) {
                                    Text("오늘의 식단")
                                        .font(.title)
                                        .bold()
                                        .padding(.horizontal, 10)
                                    
                                    HStack(alignment: .top, spacing: 70) {
                                        
                                        // Left group: Title + Calendar
                                        DatePicker(
                                            "",
                                            selection: $selectedDate,
                                            displayedComponents: .date
                                        )
                                        .datePickerStyle(.graphical)
                                        .labelsHidden()
                                        .tint(.main)
                                        .background(in: RoundedRectangle(cornerRadius: 15))
                                        .scaleEffect(1.2, anchor: .top)
                                       
                                        // Right group: Top bar (date + plus + empty-state) + List
                                        VStack(alignment: .leading, spacing: 12) {
                                            HStack(spacing: 8) {
                                                Text(selectedDate.formatted(date: .long, time: .omitted))
                                                    .font(.title3).bold()
                                                    .foregroundStyle(Color(.label))
                                                
                                                Spacer()
                                                
                                                Button {
                                                    selectedMeal = nil
                                                    isComposePresented = true
                                                } label: {
                                                    Image(systemName: "plus")
                                                        .foregroundStyle(.white)
                                                        .font(.system(size: 16, weight: .bold))
                                                        .frame(width: 36, height: 36)
                                                        .background(
                                                            Circle().fill(Color.main)
                                                        )
                                                }
                                            }
                                            .padding(.top, 4)
                                            .padding(.bottom, 6)
                                            
                                            if mealsForSelectedDate.isEmpty {
                                                VStack(spacing: 12) {
                                                    HStack(spacing: 16) {
                                                        Image(systemName: "tray")
                                                            .foregroundStyle(.secondary)
                                                        Text("아직 기록이 없어요. + 버튼으로 식사를 추가해보세요.")
                                                            .foregroundStyle(.secondary)
                                                            .font(.subheadline)
                                                        Spacer()
                                                    }
                                                    .padding()
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                                                            .fill(Color(.systemGray6))
                                                    )
                                                }
                                            }
                                            
                                            List {
                                                ForEach(mealsForSelectedDate) { meal in
                                                    TextView(item: meal)
                                                        .contentShape(Rectangle())
                                                        .onTapGesture {
                                                            selectedMeal = meal
                                                            isComposePresented = true
                                                        }
                                                        .listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
                                                }
                                                .onDelete(perform: delete)
                                                .listRowSeparator(.hidden)
                                            }
                                            .listStyle(.plain)
                                        }
                                        .padding(.top, 10)
                                    }
                                }
                                .frame(maxWidth: 1000)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.horizontal, 24)
                                .padding(.top, 12)

                                                        
                        } else {
                            // Portrait (iPad): single column centered with unified width
                            let contentWidth: CGFloat = 520
                            VStack(alignment: .center, spacing: 16) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("오늘의 식단")
                                        .font(.title)
                                        .bold()
                                        .padding(.top, 10)

                                    DatePicker(
                                        "",
                                        selection: $selectedDate,
                                        displayedComponents: .date
                                    )
                                    .datePickerStyle(.graphical)
                                    .labelsHidden()
                                    .tint(.main)
                                    .background(in: RoundedRectangle(cornerRadius: 15))
                                    .scaleEffect(1.08, anchor: .topLeading)
                                    .padding(.bottom, 10)

                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundStyle(.tertiary)
                                        .padding(.top, 6)

                                    HStack(spacing: 8) {
                                        Text(selectedDate.formatted(date: .long, time: .omitted))
                                            .font(.title3).bold()
                                            .foregroundStyle(Color(.label))

                                        Spacer()

                                        Button {
                                            selectedMeal = nil
                                            isComposePresented = true
                                        } label: {
                                            Image(systemName: "plus")
                                                .foregroundStyle(.white)
                                                .font(.system(size: 16, weight: .bold))
                                                .frame(width: 36, height: 36)
                                                .background(
                                                    Circle().fill(Color.main)
                                                )
                                        }
                                    }
                                    .padding(.top, 20)
                                    .padding(.bottom, 10)

                                    if mealsForSelectedDate.isEmpty {
                                        VStack(spacing: 12) {
                                            HStack(spacing: 16) {
                                                Image(systemName: "tray")
                                                    .foregroundStyle(.secondary)
                                                Text("아직 기록이 없어요. + 버튼으로 식사를 추가해보세요.")
                                                    .foregroundStyle(.secondary)
                                                    .font(.subheadline)
                                                Spacer()
                                            }
                                            .padding()
                                            .background(
                                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                                    .fill(Color(.systemGray6))
                                            )
                                        }
                                        .padding(.top, 10)
                                    }
                                }
                                .frame(maxWidth: contentWidth)

                                List {
                                    ForEach(mealsForSelectedDate) { meal in
                                        TextView(item: meal)
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                selectedMeal = meal
                                                isComposePresented = true
                                            }
                                            .listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
                                    }
                                    .onDelete(perform: delete)
                                    .listRowSeparator(.hidden)
                                }
                                .listStyle(.plain)
                                .frame(maxWidth: contentWidth)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 12)
                            .padding(.horizontal, 20)
                        }
                    }
                } else {
                    List {
                        VStack(alignment: .leading, spacing: 4) {
                            // 오늘의 식단
                            
                            Text("오늘의 식단")
                                .font(.title)
                                .bold()
                                .padding(.top, 10)
                            
                            // 큰 달력
                            DatePicker(
                                "",
                                selection: $selectedDate,
                                displayedComponents: .date
                            )
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                            .tint(.main)
                            .background(in: RoundedRectangle(cornerRadius: 15))
                            Rectangle()
                                .frame(height: 1)
                                .foregroundStyle(.tertiary)
                            
                            // 날짜 및 기록
                            // 선택된 날짜 표시,버튼
                            HStack(spacing: 8) {
                                Text(selectedDate.formatted(date: .long, time: .omitted))
                                    .font(.title3).bold()
                                    .foregroundStyle(Color(.label))
                                
                                Spacer()
                                
                                Button {
                                    selectedMeal = nil
                                    isComposePresented = true
                                } label: {
                                    Image(systemName: "plus")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 16, weight: .bold))
                                        .frame(width: 36, height: 36)
                                        .background(
                                            Circle().fill(Color.main)
                                        )
                                }
                            }
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                            
                            if mealsForSelectedDate.isEmpty {
                                VStack(spacing: 12) {
                                    HStack(spacing: 16) {
                                        Image(systemName: "tray")
                                            .foregroundStyle(.secondary)
                                        Text("아직 기록이 없어요. + 버튼으로 식사를 추가해보세요.")
                                            .foregroundStyle(.secondary)
                                            .font(.subheadline)
                                        Spacer()
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                                            .fill(Color(.systemGray6))
                                    )
                                }
                                .padding(.top, 18)
                            }
                        }
                        .listRowSeparator(.hidden)
                        
                        ForEach(mealsForSelectedDate) { meal in
                            TextView(item: meal)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedMeal = meal
                                    isComposePresented = true
                                }
                                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                                .padding(.horizontal)
                        }
                        .onDelete(perform: delete)
                        .listRowSeparator(.hidden)
                        
                    }
                    .padding(.horizontal, 10)
                    .listStyle(.plain) // list
                }
            }
        } // NavigationStack
        .sheet(isPresented: $isComposePresented) {
            ZStack {
                Color.white.ignoresSafeArea()
                ComposeView(mealItem: selectedMeal, date: selectedDate)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
        
} // body
    
#Preview {
    return HomeView().modelContainer(for: Meal.self, inMemory: true)
}
    
#Preview {
    
    let container = try! ModelContainer(
        for: Meal.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let context = container.mainContext
    
    for meal in sampleMeals {
        context.insert(meal)
    }
    
    
    return ContentView()
        .modelContainer(container)
        .environmentObject(DateHolder())
    
}
    
