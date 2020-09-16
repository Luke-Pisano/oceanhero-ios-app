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
    
    private var token: String? {
        userData.token
    }
    
    var isLoggedIn: Bool {
        userData.isLoggedIn
    }
    
    var userName: String? {
        userData.token
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
    func authorizationCookie(properties: [HTTPCookiePropertyKey : Any]) {
        guard let token = properties[HTTPCookiePropertyKey.value] as? String else {
            return
        }
        
        let user = User(token: token)
        userData.user = user
        
        didLogin?()
        
        //[__C.NSHTTPCookiePropertyKey(_rawValue: Name): authorization, __C.NSHTTPCookiePropertyKey(_rawValue: Created): 621954799, __C.NSHTTPCookiePropertyKey(_rawValue: Expires): 2021-09-11 13:13:40 +0000, __C.NSHTTPCookiePropertyKey(_rawValue: Value): eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzY2Y5NmJkYS04ZDk4LTRkYjYtYWUwMC05ODkxYzQzNmNmNzciLCJlbWFpbCI6Im1hcml1c3ouZ3JhY3prb3dza2lAZGlnaXRhbGZvcm1zLnBsIiwiaWF0IjoxNjAwMjYyMDIwLCJleHAiOjE2MzE4MTk2MjAsImF1ZCI6Im9jZWFuaGVyby50b2RheSIsImlzcyI6Im9jZWFuaGVyby50b2RheSJ9.K7-4omhSnP7GVLr1Y7jc5PytMIJ1vb6HEYracyTtMgY, __C.NSHTTPCookiePropertyKey(_rawValue: Domain): oceanhero.today, __C.NSHTTPCookiePropertyKey(_rawValue: Version): 1, __C.NSHTTPCookiePropertyKey(_rawValue: Path): /]
    }
}
