import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var selectedDate = Date()
    @State private var showSheet = false
    
    @Environment(\.colorScheme) var colorScheme
    
    @Model
    class Meal {
        var insertDate: Date
        var content: String
        
        init(insertDate: Date = Date(), content: String) {
            self.insertDate = insertDate
            self.content = content
        }
    }
    
    @Query(sort: [SortDescriptor(\Meal.insertDate, order: .reverse)])
    var meals: [Meal]
    
    @State var showComoser: Bool = false
    @State var keyword: String = ""
    
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
            ScrollView {
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
                    VStack {
                        // 선택된 날짜 표시,버튼
                        HStack(spacing: 8) {
                            Text(selectedDate.formatted(date: .long, time: .omitted))
                                .font(.title3).bold()
                                .foregroundStyle(Color(.label))
                            
                            Spacer()
                            
                            NavigationLink {
                                ComposeView()
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundStyle(colorScheme == .dark ? .black : .white)
                                    .font(.system(size: 16, weight: .bold))
                                    .frame(width: 36, height: 36)
                                    .background(
                                        Circle().fill(Color.main)
                                    )
                                
                            }
                            
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        
                        
                        
                        // 회고/기록 기입 없을 때
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
                        
                        // 회고/기록
                        VStack(spacing: 12) {
                            
                            // 아침
                            HStack {
                                Rectangle()
                                    .frame(width: 4)
                                    .cornerRadius(10)
                                    .foregroundStyle(.breakfast)
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("아침")
                                            .font(.subheadline)
                                        Text("토스트와 커피")
                                            .font(.headline)
                                    }
                                    Spacer()
                                    Text("07:24 am")
                                        .foregroundStyle(.secondary)
                                        .font(.subheadline)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .fill(Color(.systemGray6))
                                )
                                
                                
                            }
                            
                            // 점심
                            HStack {
                                Rectangle()
                                    .frame(width: 4)
                                    .cornerRadius(10)
                                    .foregroundStyle(.lunch)
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("점심")
                                            .font(.subheadline)
                                        Text("샐러드와 계란")
                                            .font(.headline)
                                    }
                                    Spacer()
                                    Text("12:35 pm")
                                        .foregroundStyle(.secondary)
                                        .font(.subheadline)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .fill(Color(.systemGray6))
                                )
                                
                                
                            }
                            
                        }
                        
                    } // vstack
                    .padding()
                }// ScrollView
                .padding(.horizontal)
                
            } // NavigationStack
            
        } // body
        
        //struct
        
    }
    
}
    
    
#Preview {
    HomeView()
}
    
