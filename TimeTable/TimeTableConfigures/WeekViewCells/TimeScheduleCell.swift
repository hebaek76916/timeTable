//
//  TimeScheduleCell.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/23.
//

import UIKit

class TimeScheduleCell: UITableViewCell {
    
    static let identifier = "TimeScheduleCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Self.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
