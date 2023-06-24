//
//  Extension+DateFormatter.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/24.
//

import Foundation

extension DateFormatter {
    
    static func toDate(_ string: String) -> Date? {
        let formatter = DateFormatter()
        let timeFormat = "HH:mm"
        formatter.dateFormat = timeFormat
        return formatter.date(from: string)
    }
    
}

extension Date {
    
    func minuteDiff(_ end: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: self, to: end)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        return hour * 60 + minute
    }
    
}
