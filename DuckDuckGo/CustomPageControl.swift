//
//  CustomPageControl.swift
//  DuckDuckGo
//
//  Created by Mariusz on 04/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import UIKit

class CustomPageControl: UIPageControl {
    var borderColor: UIColor = .clear

    override var currentPage: Int {
        didSet {
            updateBorderColor(dotFillColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), dotBorderColor: #colorLiteral(red: 0.3725490196, green: 0.3882352941, blue: 0.4039215686, alpha: 1), dotBorderWidth: 1)
        }
    }

    func updateBorderColor(dotFillColor: UIColor, dotBorderColor: UIColor, dotBorderWidth: CGFloat) {
        for (pageIndex, dotView) in subviews.enumerated() {
            if self.currentPage == pageIndex {
                dotView.backgroundColor = dotBorderColor
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
            } else {
                dotView.backgroundColor = dotFillColor
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
                dotView.layer.borderColor = dotBorderColor.cgColor
                dotView.layer.borderWidth = dotBorderWidth
            }
        }
    }
}
