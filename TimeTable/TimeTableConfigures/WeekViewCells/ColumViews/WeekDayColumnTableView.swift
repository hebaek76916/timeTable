//
//  WeekDayColumnTableView.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/23.
//

import UIKit

class WeekDayColumnTableView: UITableView {
    
    let timeUnitHeight = TimeTableUIPropertyValues.hourGap
    let headerViewHeight = TimeTableUIPropertyValues.weekDayHeaderHeight
    
    var weekDay: Dayofweek = .월 {
        didSet {
            tableHeaderView = headerView(weekDay: self.weekDay)
            tableHeaderView?.layoutSubviews()
        }
    }
    
    struct ScheduleUIModel {
        enum `Type` {
            case empty
            case filled
        }
        
        let type: `Type`
        let schedule: TimeScheduleModel?
        private let minutes: Int?
        
        var height: CGFloat {
            let minuteUnit = TimeTableUIPropertyValues.minuteGap
            switch type {
            case .empty:
                return CGFloat(minutes ?? 0) * minuteUnit
                
            case.filled:
                guard
                    let schedule,
                    let start = schedule.start,
                    let end = schedule.end
                else { return 0.0 }
                    
                let minuteDiff = start.minuteDiff(end)
                return CGFloat(minuteDiff) * minuteUnit
            }
        }
        
        init(_ type: `Type`, minutes: Int) {
            self.type = type
            self.minutes = minutes
            self.schedule = nil
        }
        
        init(_ type: `Type`, schedule: TimeScheduleModel) {
            self.type = type
            self.minutes = nil
            self.schedule = schedule
        }
    }
    
    private var rowModels = [ScheduleUIModel]()
    
    var schedules = [TimeScheduleModel]() {
        didSet {
            schedules.sort { $0.startTime < $1.startTime }
            
            guard
                let first = schedules.first,
                let firstStart = first.start,
                let startInit = DateFormatter.toDate("08:00")
            else { return }
            
            let firstEmptyDiff = startInit.minuteDiff(firstStart)
            self.rowModels = [ScheduleUIModel(.empty, minutes: firstEmptyDiff)]// 첫번째 강의를 위한 emptyCell

            var result = [ScheduleUIModel]()
            
            let filleds = schedules.map { ScheduleUIModel(.filled, schedule: $0) }
            
            for (index, filled) in filleds.enumerated() {
                
                result.append(filled)
                
                if index + 1 < filleds.count,
                   let nextStart = filleds[index + 1].schedule?.start
                {
                    let emptyMinutes = filled.schedule?.end?.minuteDiff(nextStart) ?? 0
                    result.append(ScheduleUIModel(.empty, minutes: emptyMinutes))
                }
            }

            self.rowModels.append(contentsOf: result)
            reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        delegate = self
        dataSource = self
        separatorStyle = .none
        bounces = false
        isScrollEnabled = false
        tableHeaderView = headerView(weekDay: self.weekDay)
        
        register(TimeScheduleCell.self, forCellReuseIdentifier: TimeScheduleCell.identifier)
        register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawTimeSeperator(rect, unit: timeUnitHeight, yPosition: headerViewHeight)
    }
}

extension WeekDayColumnTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowModels[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let model = rowModels[indexPath.row]
        guard let schedule = model.schedule else { return }
        let notification = Notification(name: Notification.Name("ExampleNotification"), object: schedule.convert())
        NotificationCenter.default.post(notification)
    }
}

extension WeekDayColumnTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let model = rowModels[indexPath.row]
        switch model.type {
        case .empty:
            let cell = dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.backgroundColor = .clear
            cell.backgroundColor = .clear
            return cell
            
        case .filled:
            guard
                let cell = dequeueReusableCell(withIdentifier: TimeScheduleCell.identifier, for: indexPath) as? TimeScheduleCell,
                let schedule = model.schedule
            else { return UITableViewCell() }
            
            cell.textLabel?.text = "\(schedule.lecture)\n\(schedule.startTime) - \(schedule.endTime)"
            cell.textLabel?.numberOfLines = 0
            cell.contentView.backgroundColor = schedule.color
            return cell
        }
        
    }
}

private extension WeekDayColumnTableView {
    
    func headerView(weekDay: Dayofweek) -> UIView {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: headerViewHeight))
        let label = UILabel.init(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
        label.text = weekDay.rawValue
        label.textColor = .blue
        view.addSubview(label)
        //TODO: date label
        view.backgroundColor = .red
        return view
    }
}
