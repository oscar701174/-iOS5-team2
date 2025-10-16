
import Foundation
import SwiftData


@Model
final class Meal : Identifiable , Hashable{
    var id:UUID
    var mealType: MealType
    var content: String             // 작성 내용
    var date: Date                  // 식사 날짜
    var time: Date                  // 식사 시간
    
    init(mealType: MealType, content: String, date: Date, time: Date) {
        self.id = UUID()
        self.mealType = mealType
        self.content = content
        self.date = date
        self.time = time
    }
    
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        lhs.mealType == rhs.mealType &&
        lhs.content == rhs.content &&
        lhs.date == rhs.date &&
        lhs.time == rhs.time
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(mealType)
        hasher.combine(content)
        hasher.combine(date)
        hasher.combine(time)
    }

}

enum MealType: String, Codable, CaseIterable, Identifiable {
    case breakfast = "아침"
    case lunch = "점심"
    case dinner = "저녁"
    case snack = "간식"
    var id: Self { self }
    
}


