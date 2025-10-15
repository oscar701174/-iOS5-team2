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
        let date: Date
    }

    private var entries: [MealEntry] = {
        let calendar = Calendar.current
        let today = Date()
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today) ?? today
        return [
            MealEntry(mealType: "아침", title: "시리얼", time: "07:24 am", date: today),
            MealEntry(mealType: "점심", title: "샐러드", time: "12:10 pm", date: today),
            MealEntry(mealType: "간식", title: "초콜렛", time: "05:08 pm", date: today),
            MealEntry(mealType: "저녁", title: "파스타", time: "07:03 pm", date: today)
        ]
    }()

    private var entriesForSelectedDate: [MealEntry] {
        let calendar = Calendar.current
        return entries.filter { calendar.isDate($0.date, inSameDayAs: selectedDate) }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // 오늘의 식단
                   
                    Text("오늘의 식단")
                        .font(.largeTitle)
                        .bold()
                        .padding(.vertical, 20)
                        
                    // 큰 달력
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .tint(.main)
                    .padding(.horizontal)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                    
                    // 날짜 및 기록
                    VStack {
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
                        .padding(.bottom, 20)
                        .padding(.top, 10)

                        
                        // 회고/기록
                        if !entriesForSelectedDate.isEmpty {
                            VStack(spacing: 20) {
                                ForEach(entriesForSelectedDate) { entry in
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
                            .sheet(item: $activeEntry) { _ in
                                ComposeView()
                                    .presentationDetents([.large, .large])
                            }
                        } else {
                            Text("이 날짜에는 기록이 없어요")
                                .foregroundStyle(.secondary)
                                .font(.callout)
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)
                
            } // ScrollView
            
        } // NavigationStack
        
    } // body
}





#Preview {
    HomeView()
}

