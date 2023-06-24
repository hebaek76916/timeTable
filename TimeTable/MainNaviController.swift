//
//  MainNaviController.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/23.
//

import UIKit

class MainNaviController: UINavigationController {
    
    let viewController: ViewController
        
    override init(rootViewController: UIViewController) {
        self.viewController = rootViewController as! ViewController
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
