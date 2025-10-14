
import SwiftUI
import SwiftData


struct HomeView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // 큰 달력
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .tint(.blue) // 포커스 색상
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                    
                    // 선택된 날짜 표시 (예: 회고/기록 영역)
                    VStack(alignment: .leading, spacing: 8) {
                        Text(selectedDate.formatted(date: .long, time: .omitted))
                            .font(.title3).bold()
                        Text("오늘의 기록을 추가해보세요.")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationTitle("오늘의 식단")
        }
    }
}


   

#Preview {
    HomeView()
}
