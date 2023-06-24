//
//  Extension+SwiftUIView.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/25.
//

import UIKit
import SwiftUI

class CustomUIView: UIView {
    private var hostingController: UIHostingController<AnyView>?
    
    func setupSwiftUIView(_ swiftUIView: AnyView) {
        hostingController = UIHostingController(rootView: swiftUIView)
        if let hostedView = hostingController?.view {
            addSubview(hostedView)
            hostedView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                hostedView.topAnchor.constraint(equalTo: topAnchor),
                hostedView.leadingAnchor.constraint(equalTo: leadingAnchor),
                hostedView.trailingAnchor.constraint(equalTo: trailingAnchor),
                hostedView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
}
