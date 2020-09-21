//
//  Router.swift
//  Core
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

public typealias RequestParameters = [String: Any]
public typealias RouterQueryString = RequestParameters

// Add routes to the Router using extensions containing instance methods.
public struct Router {
    let baseURL: String
    
    // MARK: - Initializers
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
}

extension Router {
    func route(type: RouterType) -> Route {
        return Route(method: type.method,
                     baseURL: baseURL,
                     endpoint: type.endpoint,
                     accessToken: type.token)
    }
}
