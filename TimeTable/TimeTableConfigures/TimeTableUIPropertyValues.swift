//
//  TablePropertyValues.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/23.
//

import Foundation

struct TimeTableUIPropertyValues {
    
    // 1 minute gap height
    static var minuteGap: CGFloat = 2
    
    static var hourGap: CGFloat {
        return Self.minuteGap * 60
    }
    
    static var weekDayHeaderHeight: CGFloat = 50
}
