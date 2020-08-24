//
//  IndividualBottleCounterView.swift
//  DuckDuckGo
//
//  Created by Mariusz Graczkowski on 24/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import UIKit

class IndividualBottleCounterView: UIView {
    @IBOutlet weak var smallBottleLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.size.height / 2.0
        layer.borderWidth = 1.0
        layer.borderColor = #colorLiteral(red: 0.8745098039, green: 0.8823529412, blue: 0.8980392157, alpha: 1)
        layer.masksToBounds = true
    }
}
