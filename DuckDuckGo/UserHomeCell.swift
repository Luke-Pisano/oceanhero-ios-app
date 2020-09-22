//
//  UserHomeCell.swift
//  DuckDuckGo
//
//  Created by Mariusz on 16/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import UIKit

class UserHomeCell: UICollectionViewCell {
    @IBOutlet weak var roundedBackground: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var onCreateAction: ((UserHomeCell) -> Void)?
    var onLoginAction: ((UserHomeCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        roundedBackground.layer.masksToBounds = true
        roundedBackground.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        roundedBackground.layer.borderWidth = 1.0
        roundedBackground.layer.cornerRadius = 10.0
        
        createButton.layer.masksToBounds = true
        createButton.layer.cornerRadius = 20.0
    }
}

extension UserHomeCell {
    @IBAction func onCreateHandler(_ sender: UIButton) {
        onCreateAction?(self)
    }
    
    @IBAction func onLoginHandler(_ sender: UIButton) {
        onLoginAction?(self)
    }
}

extension UserHomeCell: Themable {
    func decorate(with theme: Theme) {
        titleLabel.textColor = theme.userHomeCellTitleColor
        loginButton.setTitleColor(theme.userHomeCellLoginTitleColor, for: .normal)
        roundedBackground.backgroundColor = theme.userHomeCellBackgroundColor
        roundedBackground.layer.borderColor = theme.userHomeCellBorderColor.cgColor
    }

}
