//
//  UserClient.swift
//  DuckDuckGo
//
//  Created by Mariusz on 16/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation
import Core

class UserClient {
    private(set) var userData: UserDataType
    private(set) var apiClient: APIClientType
    
    var didLogin: (() -> Void)?
    var didLogout: (() -> Void)?
    
    private var token: String? {
        userData.token
    }
    
    var isLoggedIn: Bool {
        userData.isLoggedIn
    }
    
    var userName: String? {
        userData.user?.name
    }
    
    var userEmail: String? {
        userData.user?.email
    }
    
    // MARK: - Initializers
    
    init(with apiClient: APIClientType, userData: UserDataType) {
        self.apiClient = apiClient
        self.userData = userData
        
        if let user = userData.user {
            print(" ")
            print("USER: \(user.description)")
            print("-----------")
            print(" ")
        }
    }
}

extension UserClient {
    func logout() {
        
    }
}
    
extension UserClient {
    func authorizationCookie(properties: [HTTPCookiePropertyKey: Any]) {
        guard let token = properties[HTTPCookiePropertyKey.value] as? String else {
            return
        }
        
        _ = apiClient.request(routerType: RouterType.authorization(token), onSuccess: { [weak self] (response: UsersResponse) in
            guard let selfStrong = self else {
                return
            }
            
            let user = User(token: token, usersResponse: response)
            selfStrong.userData.user = user
            print("user: \(user.description)")
            
            DispatchQueue.main.async {
                selfStrong.didLogin?()
            }
        }, onFailure: { error in
            print("error: \(error)")
        })
    }
}
