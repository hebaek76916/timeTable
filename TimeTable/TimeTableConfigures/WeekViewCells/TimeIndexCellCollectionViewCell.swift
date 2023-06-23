//
//  TimeIndexCellCollectionViewCell.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/23.
//

import UIKit

class TimeIndexCellCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TimeIndexCellCollectionViewCell"
    
    private var columnView: TimeIndexTableView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        columnView = TimeIndexTableView()
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
