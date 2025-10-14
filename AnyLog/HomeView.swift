import SwiftUI
import SwiftData


struct HomeView: View {
    @State private var selectedDate = Date()
    @State private var showSheet = false

    @State private var activeEntry: MealEntry? = nil

    struct MealEntry: Identifiable, Hashable {
        let id = UUID()
        let mealType: String
        let title: String
        let time: String
    }

    private var entries: [MealEntry] = [
        MealEntry(mealType: "아침", title: "시리얼", time: "07:24 am"),
        MealEntry(mealType: "점심", title: "샐러드", time: "12:10 pm"),
        MealEntry(mealType: "간식", title: "초콜렛", time: "05:08 pm"),
        MealEntry(mealType: "저녁", title: "파스타", time: "07:03 pm")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // 큰 달력
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .tint(.main)
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                    
                    
                    // 선택된 날짜 표시,버튼
                    HStack(spacing: 8) {
                        Text(selectedDate.formatted(date: .long, time: .omitted))
                            .font(.title3).bold()
                        
                        Spacer()
                        
                        NavigationLink {
                            ComposeView()
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(width: 36, height: 36)
                                .background(
                                    Circle().fill(Color.main)
                                )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    
                    // 회고/기록
                    VStack(spacing: 20) {
                        ForEach(entries) { entry in
                            HStack {
                                Text(entry.mealType)

                                Spacer()

                                Text(entry.title)
                                    .bold()

                                Spacer(); Spacer(); Spacer(); Spacer();

                                Text(entry.time)
                                    .foregroundStyle(.secondary)
                            }
                            .font(.body)
                            .contentShape(Rectangle())
                            .onTapGesture { activeEntry = entry }
                        }
                    }
                    .sheet(item: $activeEntry) { entry in
                        // TODO: ComposeView로 교체 예정
                        EmptyView()
                            .presentationDetents([.large, .large])
                    }
                    .padding(.horizontal)
                    
                


                }
                .padding()
                
            } // ScrollView
            .navigationTitle("오늘의 식단")
        } // NavigationStack
        .padding(.top, -100)
    } // body
}


   

#Preview {
    HomeView()
}

