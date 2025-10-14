import Foundation
import SwiftUI
import Combine

class DateHolder: ObservableObject {
    
    @Published var dateSelected: Date = Date()
    
    var nextMonth: Date {
        Calendar.current.date(byAdding: .month, value: 1, to: dateSelected)!
    }
    var prevMonth: Date {
        Calendar.current.date(byAdding: .month, value: -1, to: dateSelected)!
    }
    
    
    func nextMonthMove() { dateSelected = nextMonth }
    
    func prevMonthMove() { dateSelected = prevMonth }
}


extension Date {
    var yearMonth: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월"
        return formatter.string(from: self)
    }
}



