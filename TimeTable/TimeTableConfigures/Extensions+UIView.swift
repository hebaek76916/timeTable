//
//  Extensions+UIView.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/23.
//

import UIKit

extension UIView {
    
    func drawTimeSeperator(
        _ rect: CGRect,
        unit: CGFloat = 60,
        yPosition offset: CGFloat = 0
    ) {
        guard
            let _ = self as? UITableView,
            let context = UIGraphicsGetCurrentContext()
        else { return }

        context.setStrokeColor(UIColor.lightGray.cgColor)
        context.setLineWidth(1.0)

        let numberOfTimeUnits = Int((bounds.height - offset) / unit)
        let yPosi: CGFloat = offset
        (0..<numberOfTimeUnits).forEach { index in
            let yPosition = yPosi + unit * CGFloat(index)
            context.move(to: CGPoint(x: rect.origin.x, y: yPosition))
            context.addLine(to: CGPoint(x: rect.origin.x + rect.size.width, y: yPosition))
        }

        context.strokePath()
    }
}
