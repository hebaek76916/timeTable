//
//  WeekView.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/23.
//

import UIKit

struct TimeScheduleModel {// 파일로 분리
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


class WeekView: UICollectionView {
    
    private let scheduledDays = Dayofweek.schoolDays
    
    //여기다가 모델을 정해야됨
    var items = [Item]()
    
    private var scheduleds: [TimeScheduleModel] {
        return self.converter(items)
    }
    
    private func converter(_ item: [Item]) -> [TimeScheduleModel] {
        
        return items.compactMap { item -> [TimeScheduleModel]? in
            guard
                let startTime = item.startTime,
                let endTime = item.endTime
            else { return nil }
            
            return (item.dayofweek ?? []).map { day in
                return TimeScheduleModel(
                    dayOfWeek: day,
                    startTime: startTime,
                    endTime: endTime,
                    lecture: item.lecture ?? "NULL",
                    professor: item.professor ?? "NULL",
                    location: item.professor ?? "NULL",
                    code: item.code ?? "NULL",
                    color: .random(),
                    siblings: item.dayofweek ?? []
                )
            }
        }.flatMap { $0 }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: TimeTableUIPropertyValues.timeTableCollectionFlowLayout)
        setUpCollectionView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension WeekView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let timeIndexColumnWidth = 32.0
        let weekDaysWidth = UIScreen.main.bounds.width - timeIndexColumnWidth
        
        if indexPath.row == 0 {
            return CGSize(width: timeIndexColumnWidth, height: self.frame.height)
        }
        
        let columns = CGFloat(scheduledDays.count)
        return CGSize(width: weekDaysWidth / columns, height: TimeTableUIPropertyValues.hourGap * 24 + 50)
    }
}

extension WeekView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scheduledDays.count + 1//(+ 1 = time Index)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeIndexCellCollectionViewCell.identifier, for: indexPath) as? TimeIndexCellCollectionViewCell
            else { return UICollectionViewCell() }
            return cell
        }
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekDayColumnCell.identifier, for: indexPath) as? WeekDayColumnCell
        else { return UICollectionViewCell() }
        
        let weekDay = scheduledDays[indexPath.row - 1]
        cell.weekDay = weekDay
        
        let models = scheduleds.filter { $0.dayOfWeek == weekDay }
        cell.schedules = models
        
        return cell
    }
    
}

private extension WeekView {
    
    func setUpCollectionView() {
        delegate = self
        dataSource = self
        register(WeekDayColumnCell.self, forCellWithReuseIdentifier: WeekDayColumnCell.identifier)
        register(TimeIndexCellCollectionViewCell.self, forCellWithReuseIdentifier: TimeIndexCellCollectionViewCell.identifier)
    }
}
