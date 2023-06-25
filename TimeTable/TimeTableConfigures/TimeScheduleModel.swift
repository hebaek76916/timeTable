//
//  TimeScheduleModel.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/25.
//

import Foundation
import UIKit.UIColor

struct TimeScheduleModel {
    let dayOfWeek: Dayofweek
    let startTime: String
    let endTime: String
    let lecture: String
    let professor: String
    let location: String
    
    let code: String
    let color: UIColor
    
    var start: Date? {
        DateFormatter.toDate(startTime)
    }
    
    var end: Date? {
        DateFormatter.toDate(endTime)
    }
    
    let siblings: [Dayofweek]
    
    func convert() -> Item {
        return Item(
            dayofweek: siblings,
            code: code,
            location: location,
            lecture: lecture,
            professor: professor,
            startTime: startTime,
            endTime: endTime
        )
    }
}
