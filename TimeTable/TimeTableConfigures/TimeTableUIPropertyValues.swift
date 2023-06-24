//
//  TablePropertyValues.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/23.
//

import Foundation

struct TimeTableUIPropertyValues {
    
    // 1 minute gap height
    static let minuteGap: CGFloat = 2
    static var hourGap: CGFloat {
        return Self.minuteGap * 60
    }
    
    static let weekDayHeaderHeight: CGFloat = 50
}
