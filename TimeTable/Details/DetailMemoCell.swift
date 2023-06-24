//
//  DetailMemoCell.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/25.
//

import UIKit

class DetailMemoCell: UITableViewCell {
    
    static let identifier = "DetailMemoCell"
    
    private let view = UIView()
    private let memoTextLabel = UILabel()
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension DetailMemoCell {
    
    func setUpUI() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        [
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.heightAnchor.constraint(equalToConstant: 68)
        ].forEach { $0.isActive = true }
        
        let memoIconImageView = UIImageView()
        memoIconImageView.backgroundColor = .red
        memoIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        memoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(memoIconImageView)
        [
            memoIconImageView.widthAnchor.constraint(equalToConstant: 30),
            memoIconImageView.heightAnchor.constraint(equalToConstant: 30),
            memoIconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                       constant: 24),
            memoIconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ].forEach { $0.isActive = true }
        
        memoTextLabel.text = "메모다"
        view.addSubview(memoTextLabel)
        [
            memoTextLabel.centerYAnchor.constraint(equalTo: memoIconImageView.centerYAnchor),
            memoTextLabel.leadingAnchor.constraint(equalTo: memoIconImageView.trailingAnchor,
                                                   constant: 12)
        ].forEach { $0.isActive = true }
        
        contentView.addSubview(deleteButton)
        [
            deleteButton.widthAnchor.constraint(equalToConstant: 30),
            deleteButton.heightAnchor.constraint(equalToConstant: 23),
            deleteButton.centerYAnchor.constraint(equalTo: memoIconImageView.centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: -24)
        ].forEach { $0.isActive = true }
    }
}
