//
//  Extension+UIColor.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/25.
//

import UIKit.UIColor

extension UIColor {
    
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0.5...1.0)
        let green = CGFloat.random(in: 0.5...1.0)
        let blue = CGFloat.random(in: 0.5...1.0)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
