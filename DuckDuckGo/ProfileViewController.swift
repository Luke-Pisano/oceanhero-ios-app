//
//  ProfileViewController.swift
//  DuckDuckGo
//
//  Created by Mariusz on 22/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    weak var userClient: UserClient!
    var didLogout: (() -> Void)?
    
    private var userName: String {
        userClient.userName ?? ""
    }
    
    private var userEmail: String {
        userClient.userEmail ?? ""
    }
    
    static func loadFromStoryboard() -> UIViewController {
        return UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController()!
    }
    
    // MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

extension ProfileViewController {
    private func configureUI() {
        avatarView.configure(name: userName)
        nameLabel.text = userName
        emailLabel.text = userEmail
        
        logoutButton.layer.masksToBounds = true
        logoutButton.layer.cornerRadius = logoutButton.frame.size.height / 2
        logoutButton.layer.borderColor = #colorLiteral(red: 0.3529411765, green: 0.3529411765, blue: 0.3529411765, alpha: 1)
        logoutButton.layer.borderWidth = 1.0
    }
}

extension ProfileViewController {
    @IBAction func onDonePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onLogoutHandler(_ sender: Any) {
        didLogout?()
        dismiss(animated: true, completion: nil)
    }
}
