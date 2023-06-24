//
//  ViewController.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/21.
//

import UIKit

class ViewController: UIViewController {

    var client: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    lazy var a = LecturesServiceAPI(
        url: LecturesEndPoint.lecturesName("데이터").url(),
        client: client
    )
    
    let weekView = WeekView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()

        view.backgroundColor = .blue
        view.addSubview(weekView)
        weekView.frame = view.frame
        weekView.backgroundColor = .clear
    }
    
    private func setNavigation() {
        navigationItem.title = "시간표"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        let searchButton = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(searchButtonTapped)
        )
        
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc func searchButtonTapped() {
        let vc = SearchController()
        vc.view.backgroundColor = .brown
        navigationController?.pushViewController(vc, animated: true)
    }
}

