//
//  WeekDayColumnTableView.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/23.
//

import UIKit

enum WeekDay: String, CaseIterable {
    case mon, tue, wed, thu, fri, sat, sun
    
    var abbreviation: String {
        return self.rawValue.uppercased()
    }
}

class WeekDayColumnTableView: UITableView {
    
    let timeUnitHeight = TimeTableUIPropertyValues.hourGap
    let headerViewHeight = TimeTableUIPropertyValues.weekDayHeaderHeight
    
    var weekDay: WeekDay = .mon {
        didSet {
            tableHeaderView = headerView(weekDay: self.weekDay)
            tableHeaderView?.layoutSubviews()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        delegate = self
        dataSource = self
        separatorStyle = .none
        bounces = false
        tableHeaderView = headerView(weekDay: self.weekDay)
        
        register(TimeScheduleCell.self, forCellReuseIdentifier: TimeScheduleCell.identifier)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawTimeSeperator(rect, unit: timeUnitHeight, yPosition: headerViewHeight)
    }

    private func headerView(weekDay: WeekDay) -> UIView {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: headerViewHeight))
        let label = UILabel.init(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
        label.text = weekDay.abbreviation
        label.textColor = .blue
        view.addSubview(label)
        //TODO: date label
        view.backgroundColor = .red
        return view
    }
}

extension WeekDayColumnTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return timeUnitHeight
    }
}

extension WeekDayColumnTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = dequeueReusableCell(withIdentifier: TimeScheduleCell.identifier, for: indexPath) as? TimeScheduleCell
        else { return UITableViewCell() }
        
        cell.contentView.backgroundColor = .green
        cell.textLabel?.text = "index: \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3// cell 통일 해야하지 않나?
    }
    
}
