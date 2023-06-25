//
//  TablePropertyValues.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/23.
//

import UIKit

struct TimeTableUIPropertyValues {
    
    // 1 minute gap height
    static let minuteGap: CGFloat = 1
    static var hourGap: CGFloat {
        return Self.minuteGap * 60
    }
    
    static let weekDayHeaderHeight: CGFloat = 50
    
    static var timeTableCollectionFlowLayout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumInteritemSpacing = 1
        flow.minimumLineSpacing = 2
        flow.sectionInset = .zero
        
        let days = CGFloat(Dayofweek.schoolDays.count)
        
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width / days, height: UIScreen.main.bounds.height)
        return flow
    }()
}
