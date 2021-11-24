//
//  RouterType.swift
//  Core
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Alamofire

public enum RouterType {
    case bottleCount
}

extension RouterType {
    public var method: HTTPMethod {
        switch self {
        case .bottleCount:
            return .get
        }
    }
}

extension RouterType {
    public var endpoint: String {
        switch self {
        case .bottleCount:
            return "/counter"
        }
    }
}
