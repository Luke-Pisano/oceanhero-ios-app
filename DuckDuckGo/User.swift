//
//  User.swift
//  DuckDuckGo
//
//  Created by Mariusz on 16/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation
import Core

public class User: Codable {
    let token: String
    let id: String
    let name: String
    let email: String
    let level: Int
    
    // MARK: - Initializers
    
    init(token: String, usersResponse: UsersResponse) {
        self.token = token
        self.id = usersResponse.id
        self.name = usersResponse.name
        self.email = usersResponse.email
        self.level = usersResponse.level
    }
}

extension User {
    var description: String {
        #if DEBUG
            return "\ntoken: \(token)" +
                    "\nid: \(id)" +
                    "\nname: \(name)" +
                    "\nemail: \(email)" +
                    "\nlevel: \(level)"
        #else
            return ""
        #endif
    }
}
