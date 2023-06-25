//
//  LectureDetailViewController.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/25.
//

import UIKit
import SwiftUI

class LectureDetailViewController: UIViewController {
    
    enum ViewType {
        case add
        case edit
        
        var description: String {
            switch self {
            case .add:  return "강의 추가"
            case .edit: return "메모 추가"
            }
        }
    }
    
    let `type`: ViewType
    let item: Item
    
    enum DetailSectionType: Int {//rawValue = # of section row
        case descriptions = 0
        case text
        case memo
    }
    
    private let tableView = UITableView()
    private var sections: [DetailSectionType] {
        switch type {
        case .add:   return [.descriptions, .text]
        case .edit:  return [.descriptions, .text, .memo]
        }
    }
    
    let viewTypeActionButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blue
        return button
    }()
    
    init(_ type: ViewType, item: Item) {
        self.type = type
        self.item = item
        super.init(nibName: nil, bundle: nil)
        
        viewTypeActionButton.setTitle(self.`type`.description, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never

        setUpUI()
        setUpTableView()
    }
}

extension LectureDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension LectureDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .descriptions:
            return 1
        case .text:
            return 1
        case .memo:
            return 3//TODO: memo 갯수에 따라서...
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let `default` = UITableViewCell()
        guard let sectionType = DetailSectionType(rawValue: indexPath.section) else { return `default` }
        
        switch sectionType {
        case .descriptions:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailDescriptionsViewCell.identifier, for: indexPath) as? DetailDescriptionsViewCell
            else { return `default` }
            cell.lectureData = LectureData(item: item)
            cell.lectureData.map { lectureData in
                
                let lectureView = DetailDescriptionsView(lecture: lectureData)
                let sv = AnyView(lectureView)
                
                let customUIView = CustomUIView()
                customUIView.setupSwiftUIView(sv)
                customUIView.translatesAutoresizingMaskIntoConstraints = false
                cell.contentView.addSubview(customUIView)
                [
                    customUIView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor,
                                                          constant: 12),
                    customUIView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor,
                                                           constant: -12),
                    customUIView.topAnchor.constraint(equalTo: cell.contentView.topAnchor,
                                                      constant: 12),
                    customUIView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor,
                                                         constant: -12)
                ].forEach { $0.isActive = true }
                
            }
            return cell
            
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "강의 설명"
            return cell
        case .memo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailMemoCell.identifier, for: indexPath) as? DetailMemoCell else { return `default` }
            cell.backgroundColor = .systemPink
            return cell
        }
    }
    
}

private extension LectureDetailViewController {
    
    private func setUpUI() {
        viewTypeActionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewTypeActionButton)
        [
            viewTypeActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewTypeActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewTypeActionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewTypeActionButton.heightAnchor.constraint(equalToConstant: 72)
        ].forEach { $0.isActive = true }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: viewTypeActionButton.topAnchor)
        ].forEach { $0.isActive = true }
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(DetailDescriptionsViewCell.self, forCellReuseIdentifier: DetailDescriptionsViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(DetailMemoCell.self, forCellReuseIdentifier: DetailMemoCell.identifier)
    }
}
