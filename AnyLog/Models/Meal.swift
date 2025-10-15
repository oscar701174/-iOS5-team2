//
//  Meal.swift
//  AnyLog
//
//  Created by 조영준 on 10/14/25.
//

import Foundation
import SwiftData


@Model
final class Meal {
    var mealType: MealType
    var content: String             // 작성 내용
    var date: Date                  // 식사 날짜
    var time: Date                  // 식사 시간
    
    init(mealType: MealType, content: String, date: Date, time: Date) {
        self.mealType = mealType
        self.content = content
        self.date = date
        self.time = time
    }
}

enum MealType: String, Codable, CaseIterable, Identifiable {
    case breakfast = "아침"
    case lunch = "점심"
    case dinner = "저녁"
    case snack = "간식"
    
    var id: Self { self }
}

