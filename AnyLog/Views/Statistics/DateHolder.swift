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
    
    init(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0) {
        var comps = DateComponents()
        comps.year = year
        comps.month = month
        comps.day = day
        comps.hour = hour
        comps.minute = minute
        self = Calendar.current.date(from: comps)!
    }
    
    
    var yearMonth: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월"
        return formatter.string(from: self)
    }
    
    
    var hour: Int {
        let calendar = Calendar.current
        return calendar.component(.hour, from: self)
    }
}


