//
//  APIParserType.swift
//  Core
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

public typealias APIParserFailure = (APIParserError) -> Void

public protocol APIParserType {
    func parse<T: Decodable>(response: APIServiceResponseType, onSuccess: @escaping (T) -> Void, onFailure: @escaping (APIParserError) -> Void)
}
