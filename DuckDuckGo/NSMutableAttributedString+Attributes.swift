//
//  NSMutableAttributedString+Attributes.swift
//  DuckDuckGo
//
//  Created by Mariusz on 04/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    fileprivate var range: NSRange {
        return NSRange(location: 0, length: length)
    }
    
    fileprivate var paragraphStyle: NSMutableParagraphStyle? {
        return attributes(at: 0, effectiveRange: nil)[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle
    }
}

extension NSMutableAttributedString {
    func lineSpacing(_ value: CGFloat) -> Self {
        guard !string.isEmpty else {
            return self
        }
        
        let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = value
        
        addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        
        return self
    }
    
    func font(font: UIFont) -> Self {
        addAttributes([NSAttributedString.Key.font: font], range: range)
        return self
    }
    
    func font(for range: NSRange, font: UIFont) -> Self {
        addAttributes([NSAttributedString.Key.font: font], range: range)
        return self
    }
    
    func color(for range: NSRange, color: UIColor) -> Self {
        addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        return self
    }
    
    func color(value: UIColor) -> Self {
        return color(for: range, color: value)
    }
}
