//
//  JSONEncoder+API.swift
//  Core
//
//  Created by Mariusz on 21/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

extension JSONEncoder {
    static var APIEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.APIFormatter)
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        return encoder
    }()
}
