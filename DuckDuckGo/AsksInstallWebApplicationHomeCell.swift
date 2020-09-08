//
//  AsksInstallWebApplicationHomeCell.swift
//  DuckDuckGo
//
//  Created by Mariusz on 07/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import UIKit

class AsksInstallWebApplicationHomeCell: UICollectionViewCell {
    @IBOutlet weak var roundedBackground: RoundedRectangleView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    var onLeftAction: ((AsksInstallWebApplicationHomeCell) -> Void)?
    var onRightAction: ((AsksInstallWebApplicationHomeCell) -> Void)?
    
    var state: HomeAsksInstallWebApplicationState = .doYouUseOceanHero {
        didSet {
            guard state != oldValue else {
                return
            }
            
            configureUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        AsksInstallWebApplicationHomeCell.applyDropshadow(to: roundedBackground!)
        
        rightButton.layer.masksToBounds = true
        rightButton.layer.cornerRadius = 19.0
        
        leftButton.layer.masksToBounds = true
        leftButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        leftButton.layer.borderWidth = 1.0
        leftButton.layer.cornerRadius = 19.0
        
        configureUI()
    }
    
    class func applyDropshadow(to view: UIView) {
        view.layer.shadowRadius = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.12
        view.layer.masksToBounds = false
    }
}

extension AsksInstallWebApplicationHomeCell {
    private func configureUI() {
        titleLabel.text = state.title
        leftButton.setTitle(state.leftButtonTitle, for: .normal)
        rightButton.setTitle(state.rightButtonTitle, for: .normal)
        
        leftButton.isHidden = state.leftButtonTitle == nil
    }
}

extension AsksInstallWebApplicationHomeCell {
    @IBAction func onLeftHandler(_ sender: UIButton) {
        onLeftAction?(self)
    }
    
    @IBAction func onRightHandler(_ sender: UIButton) {
        onRightAction?(self)
    }
}
