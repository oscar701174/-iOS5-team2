import SwiftUI
import SwiftData

struct TextView: View {
    let item: Meal
    
    private var mealStyle: some ShapeStyle {
        switch item.mealType {
        case .breakfast:
            return .breakfast
        case .lunch:
            return .lunch
        case .dinner:
            return .dinner
        case .snack:
            return .snack
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
           
            // 아침
            HStack {
                Rectangle()
                    .frame(width: 4, height: 70)
                    .foregroundStyle(mealStyle)
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.mealType.rawValue.capitalized)
                            .font(.subheadline)
                        Text(item.content)
                            .font(.headline)
                    }
                    Spacer()
                    Text(item.time.formatted(date: .omitted, time: .shortened))
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(.systemGray6))
                )
//                .overlay(alignment: .leading) {
//                    Rectangle()
//                        .frame(width: 4)
//                        .cornerRadius(10)
//                        .foregroundStyle(.breakfast)
//                }
            }
        }
    }
}

#Preview {
    // 인메모리 SwiftData 컨테이너 생성
    struct TextViewPreview: View {
        let container: ModelContainer
        @State private var sampleItem: Meal
        
        init() {
            // 모델 컨테이너 구성
            let schema = Schema([Meal.self])
            let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
            self.container = try! ModelContainer(for: schema, configurations: [configuration])
            
            // ContentView.addTestData()와 동일한 샘플 데이터
            let sampleMeals2: [Meal] = [
                Meal(mealType: .breakfast,
                     content: "토스트와 커피",
                     date: Date(year: 2025, month: 10, day: 15),
                     time: Date(year: 2025, month: 10, day: 15, hour: 7, minute: 15)),
                Meal(mealType: .lunch,
                     content: "닭가슴살 샐러드와 고구마",
                     date: Date(year: 2025, month: 10, day: 15),
                     time: Date(year: 2025, month: 10, day: 15, hour: 12, minute: 25)),
                Meal(mealType: .dinner,
                     content: "된장찌개, 밥, 김치",
                     date: Date(year: 2025, month: 10, day: 15),
                     time: Date(year: 2025, month: 10, day: 15, hour: 19, minute: 30)),
                Meal(mealType: .snack,
                     content: "요거트와 블루베리",
                     date: Date(year: 2025, month: 10, day: 15),
                     time: Date(year: 2025, month: 10, day: 15, hour: 16, minute: 0)),
                Meal(mealType: .breakfast,
                     content: "오트밀과 바나나",
                     date: Date(year: 2025, month: 10, day: 14),
                     time: Date(year: 2025, month: 10, day: 14, hour: 7, minute: 50)),
                Meal(mealType: .lunch,
                     content: "비빔밥과 미역국",
                     date: Date(year: 2025, month: 10, day: 14),
                     time: Date(year: 2025, month: 10, day: 14, hour: 13, minute: 10)),
                Meal(mealType: .dinner,
                     content: "연어 스테이크와 구운 채소",
                     date: Date(year: 2025, month: 10, day: 14),
                     time: Date(year: 2025, month: 10, day: 14, hour: 18, minute: 50)),
                Meal(mealType: .snack,
                     content: "아몬드 한 줌",
                     date: Date(year: 2025, month: 10, day: 14),
                     time: Date(year: 2025, month: 10, day: 14, hour: 15, minute: 30)),
                Meal(mealType: .breakfast,
                     content: "스크램블에그와 오렌지 주스",
                     date: Date(year: 2025, month: 10, day: 13),
                     time: Date(year: 2025, month: 10, day: 13, hour: 8, minute: 5)),
                Meal(mealType: .dinner,
                     content: "파스타와 샐러드",
                     date: Date(year: 2025, month: 10, day: 13),
                     time: Date(year: 2025, month: 10, day: 13, hour: 19, minute: 20))
            ]
            
            // 컨텍스트에 삽입
            let context = ModelContext(container)
            for meal in sampleMeals2 {
                context.insert(meal)
            }
            try? context.save()
            
            // 하나 선택해서 미리보기 아이템으로
            _sampleItem = State(initialValue: sampleMeals2.first!)
        }
        
        var body: some View {
            TextView(item: sampleItem)
                .modelContainer(container)
        }
    }
    
    return TextViewPreview()
}

