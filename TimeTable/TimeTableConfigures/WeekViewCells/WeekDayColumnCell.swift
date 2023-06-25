//
//  WeekDayColumnCell.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/23.
//

import UIKit

class WeekDayColumnCell: UICollectionViewCell {
    
    static let identifier = "WeekDayColumnCell"
    
    private var columnView: WeekDayColumnTableView?
    
    var weekDay: Dayofweek = .월 {
        didSet {
            columnView?.weekDay = self.weekDay
        }
    }
    
    var schedules = [TimeScheduleModel]() {
        didSet {
            columnView?.schedules = self.schedules
            //TODO: reload data?
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        columnView = WeekDayColumnTableView()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setUpUI() {
        guard let columnView else { return }
        columnView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(columnView)
        [
            columnView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            columnView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            columnView.topAnchor.constraint(equalTo: contentView.topAnchor),
            columnView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].forEach { $0.isActive = true }
    }
}
