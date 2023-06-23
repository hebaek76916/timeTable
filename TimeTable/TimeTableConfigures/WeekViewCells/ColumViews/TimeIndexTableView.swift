//
//  TimeIndexTableView.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/23.
//

import UIKit

class TimeIndexTableView: UITableView {
    
    static let identifier = "TimeIndexTableView"

    let timeUnitHeight = TimeTableUIPropertyValues.hourGap
    let headerViewHeight = TimeTableUIPropertyValues.weekDayHeaderHeight

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        delegate = self
        dataSource = self
        separatorStyle = .none
        bounces = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawTimeSeperator(rect, unit: timeUnitHeight, yPosition: headerViewHeight)
    }
}

extension TimeIndexTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: timeIndex
        return UITableViewCell()
    }
    
}

extension TimeIndexTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TimeTableUIPropertyValues.hourGap
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return TimeTableUIPropertyValues.weekDayHeaderHeight
    }
}
