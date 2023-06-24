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
        label.font = .systemFont(ofSize: 8)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timeLabel)
        [
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ].forEach { $0.isActive = true }
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor.green.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
