//
//  AvatarView.swift
//  DuckDuckGo
//
//  Created by Mariusz on 21/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import UIKit

class AvatarView: UIView {
    var onTouchAction: (() -> Void)?
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        addSubview(button)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[button]|", options: [], metrics: nil, views: ["button": button]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[button]|", options: [], metrics: nil, views: ["button": button]))
        
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        addSubview(imageView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: [], metrics: nil, views: ["imageView": imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|", options: [], metrics: nil, views: ["imageView": imageView]))
        
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.arialFont(ofSize: 23)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.allowsDefaultTighteningForTruncation = true
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-margin-[label]-margin-|", options: [], metrics: ["margin": margin], views: ["label": label]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: [], metrics: nil, views: ["label": label]))
        
        return label
    }()
    
    private var margin: CGFloat {
        radius * 0.2
    }
    
    private var radius: CGFloat {
        frame.size.width / 2
    }
    
    // MARK: - Lifecycle
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = radius
        updateUI()
    }
}

extension AvatarView {
    private func configureUI() {
        layer.masksToBounds = true
        backgroundColor = #colorLiteral(red: 0, green: 0.6, blue: 1, alpha: 1)
        
        imageView.image = nil
        label.text = ""
        button.addTarget(self, action: #selector(onTouchHandler), for: .touchUpInside)
    }
    
    private func updateUI() {
        label.font = UIFont.arialFont(ofSize: CGFloat(radius))
    }
    
    func configure(name: String) {
        let names = name.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")
            
        if names.count > 1 {
            let firstName = names[0]
            let lastName = names[names.count - 1]
            
            let firstNameInitial = firstName[0].uppercased()
            let lastNameInitial = lastName[0].uppercased()
            
            label.text = (firstNameInitial + lastNameInitial)
        } else if name != ""{
            label.text = name[0].uppercased()
        }
    }
}

extension AvatarView {
    @objc
    func onTouchHandler() {
        onTouchAction?()
    }
}
