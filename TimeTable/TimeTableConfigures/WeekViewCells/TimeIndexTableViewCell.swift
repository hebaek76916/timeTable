//
//  TimeIndexTableViewCell.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/25.
//

import UIKit

class TimeIndexTableViewCell: UITableViewCell {

    static let identifier = "TimeIndexTableViewCell"
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .purple
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timeLabel)
        [
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ].forEach { $0.isActive = true }
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemPink.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
