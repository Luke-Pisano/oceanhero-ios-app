//
//  UsersResponse.swift
//  Core
//
//  Created by Mariusz on 21/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

public class UsersResponse: Decodable {
    public let id: String
    public let name: String
    public let email: String
    public let level: Int
    public let counter: Int
}
