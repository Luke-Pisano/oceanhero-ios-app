//
//  User.swift
//  DuckDuckGo
//
//  Created by Mariusz on 16/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

public class User: Codable {
    let token: String
    
    // MARK: - Initializers
    
    init(token: String) {
        self.token = token
    }
}

extension User {
    var description: String {
        #if DEBUG
            return "\ntoken: \(token)"
        #else
            return ""
        #endif
    }
}
