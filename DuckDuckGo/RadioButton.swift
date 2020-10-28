//
//  RadioButton.swift
//  DuckDuckGo
//
//  Created by Mariusz on 20/10/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import UIKit

class RadioButton: UIView {
    private struct Constants {
        static let defaultIconSize: CGFloat = 30.0
    }
    
    private lazy var imageViewHeightConstraint: NSLayoutConstraint = {
        iconImageView.heightAnchor.constraint(equalToConstant: iconSize)
    }()
    
    private lazy var imageViewWidthConstraint: NSLayoutConstraint = {
        iconImageView.widthAnchor.constraint(equalToConstant: iconSize)
    }()
    
    private lazy var imageViewLeftConstraint: NSLayoutConstraint = {
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0.0)
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        let constraints = [
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.textColor = #colorLiteral(red: 0.368627451, green: 0.3882352941, blue: 0.4039215686, alpha: 1)
        label.font = UIFont.arialFont(ofSize: 17.0)
        
        let constraints = [
            label.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 20.0),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 0.0),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        return label
    }()
    
    private lazy var masterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        let constraints = [
            button.leftAnchor.constraint(equalTo: leftAnchor, constant: 0.0),
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: 0.0),
            button.topAnchor.constraint(equalTo: topAnchor, constant: 0.0),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        return button
    }()
    
    private lazy var bigCircleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.layer.borderWidth = 1.0
        view.layer.borderColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 1, alpha: 1)
        
        let constraints = [
            view.rightAnchor.constraint(equalTo: rightAnchor, constant: 0.0),
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: 20),
            view.heightAnchor.constraint(equalTo: view.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        return view
    }()
    
    private lazy var smallCircleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.backgroundColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 1, alpha: 1)
        
        let constraints = [
            view.centerXAnchor.constraint(equalTo: bigCircleView.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: bigCircleView.centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: 12),
            view.heightAnchor.constraint(equalTo: view.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        return view
    }()
    
    // MARK: - Public
    
    var title: String? = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var icon: UIImage? = #imageLiteral(resourceName: "searchProvider_Oceanhero") {
        didSet {
            iconImageView.image = icon
        }
    }
    
    var isActive: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    var iconSize: CGFloat = Constants.defaultIconSize {
        didSet {
            imageViewHeightConstraint.constant = iconSize
            imageViewWidthConstraint.constant = iconSize
            imageViewLeftConstraint.constant = (Constants.defaultIconSize - iconSize) / 2
        }
    }
    
    var onChangeActiveState: ((RadioButton) -> Void)?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bigCircleView.layer.cornerRadius = bigCircleView.frame.size.width / 2
        smallCircleView.layer.cornerRadius = smallCircleView.frame.size.width / 2
    }
}

extension RadioButton {
    private func setup() {
        iconImageView.image = icon
        titleLabel.text = title
        
        bigCircleView.layer.masksToBounds = true
        smallCircleView.layer.masksToBounds = true
        
        masterButton.addTarget(self, action: #selector(onChangeRadioButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([imageViewLeftConstraint, imageViewHeightConstraint, imageViewWidthConstraint])
        
        updateUI()
    }
    
    private func updateUI() {
        smallCircleView.isHidden = !isActive
    }
}

extension RadioButton {
    @objc
    func onChangeRadioButton(sender: UIButton) {
        guard !isActive else {
            return
        }
        
        isActive = !isActive
        onChangeActiveState?(self)
    }
}
