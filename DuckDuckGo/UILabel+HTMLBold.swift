//
//  UILabel+HTMLBold.swift
//  DuckDuckGo
//
//  Created by Mariusz on 04/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import UIKit

extension UILabel {
    func htmlBold(text: String) {
        var value = text
        let startBold = "<b>"
        let endBold = "</b>"
        
        guard let startRange = text.range(of: startBold), let endRange = text.range(of: endBold) else {
            self.text = text
            return
        }
        
        let startIndex = NSRange(startRange, in: startBold).location
        let endIndex = NSRange(endRange, in: endBold).location - startBold.count
        let range = NSRange(location: startIndex, length: endIndex - startIndex)
        
        value.removeSubrange(endRange)
        value.removeSubrange(startRange)
        
        self.attributedText =  NSMutableAttributedString(string: value) .font(for: range,
                                                                              font: .boldRobotoFont(ofSize: self.font.pointSize))
    }
}
