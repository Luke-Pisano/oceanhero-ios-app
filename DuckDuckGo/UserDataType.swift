//
//  UserDataType.swift
//  DuckDuckGo
//
//  Created by Mariusz on 16/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

protocol UserDataType {
    var isLoggedIn: Bool { get }
    var token: String? { get }
    var user: User? { get set }
}
