//
//  SeparatorLineView.swift
//  DuckDuckGo
//
//  Created by Mariusz on 20/10/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import UIKit

class SeparatorLineView: UIView {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        heightConstraint.constant = 2.0 / UIScreen.main.scale
    }
}
