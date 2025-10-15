import SwiftUI
import SwiftData

struct TextView: View {
    let item: Meal
    
    var body: some View {
        VStack(alignment: .leading) {
           
                
            
            // 아침
            HStack {
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
                .overlay(alignment: .leading) {
                    Rectangle()
                        .frame(width: 4)
                        .cornerRadius(10)
                        .foregroundStyle(.breakfast)
                }
                
                
            }
        }
    }
}

#Preview {
    TextView(
        item: Meal(
            mealType: .breakfast,
            content: "Test",
            date: Date(),
            time: Date()
        )
    )
}

