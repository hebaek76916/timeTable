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
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setNavigation()
        setUpUI()
        weekView.items = LecturesResponse.temp
        
        // Register for a specific notification
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: Notification.Name("ExampleNotification"), object: nil)

    }
    
    @objc func handleNotification(_ notification: Notification) {
        // Handle the notification here
        if let item = notification.object as? Item {
            let vc = LectureDetailViewController(.edit, item: item)
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    private func setUpUI() {

        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: TimeTableUIPropertyValues.hourGap * 24 + 50)
        scrollView.frame = view.frame
        scrollView.backgroundColor = .orange
        view.addSubview(scrollView)
        [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach { $0.isActive = true }


        weekView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: TimeTableUIPropertyValues.hourGap * 24 + 50)
        scrollView.addSubview(weekView)
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
