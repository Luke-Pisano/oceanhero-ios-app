//
//  JSONDecoder+API.swift
//  Core
//
//  Created by Mariusz on 21/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

extension JSONDecoder {
    static var APIDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.APIFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }()
}
