//
//  SearchController.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/23.
//

import UIKit
import SwiftUI

class SearchController: UIViewController {    

    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView = UITableView()
    
    private var client: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    private lazy var lectureAPIService = LecturesServiceAPI(
        url: LecturesEndPoint.lectures.url(),
        client: client
    )
    
    private var items = [Item]()
    
    private var filteredItems: [Item] {
        let text = searchController.searchBar.text ?? ""
        if text.isEmpty {
            return items
        } else {
            return items.filter {
                ($0.lecture?.localizedCaseInsensitiveContains(text) == true) ||
                ($0.professor?.localizedCaseInsensitiveContains(text) == true) ||
                ($0.code?.localizedCaseInsensitiveContains(text) == true) ||
                ($0.location?.localizedCaseInsensitiveContains(text) == true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchController()
        setUpUI()
        setUpTableView()
        
        lectureAPIService.load { res in
            switch res {
            case.success(let data):
                guard let items = data.items else { return }
                self.items = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure:
                return
            }
        }
    }
}

extension SearchController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }
}

extension SearchController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension SearchController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchLectureCell.identifier, for: indexPath) as? SearchLectureCell
        else { return UITableViewCell() }

        let item = filteredItems[indexPath.row]
        
        cell.configure(with: item)
        cell.lectureData.map { lectureData in
            let lectureView = LectureView(lecture: lectureData)
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
        cell.backgroundColor = .yellow
        return cell
    }
    
}

private extension SearchController {
    
    private func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setUpUI() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach { $0.isActive = true }
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchLectureCell.self, forCellReuseIdentifier: SearchLectureCell.identifier)
    }
}
