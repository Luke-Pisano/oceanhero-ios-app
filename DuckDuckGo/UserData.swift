//
//  UserData.swift
//  DuckDuckGo
//
//  Created by Mariusz on 16/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

class UserData: UserDataType {
    var appConfiguration: AppConfigurationUser
    
    var token: String? {
        return user?.token
    }

    var user: User? {
        didSet {
            guard let user = user else {
                return
            }
            
            appConfiguration.user = user
        }
    }

    var isLoggedIn: Bool {
        user != nil
    }
    
    // MARK: - Initializers
    
    init(appConfiguration: AppConfigurationUser) {
        self.appConfiguration = appConfiguration
        user = appConfiguration.user
    }
}
