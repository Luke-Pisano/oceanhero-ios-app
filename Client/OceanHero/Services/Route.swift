//
//  Route.swift
//  Core
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Alamofire
import Foundation

public enum RouteError: Error {
    case invalidURL
}

public enum RouteAcceptType: String {
    case json = "application/json"
    case image = "application/octet-stream"
}

public struct Route: URLRequestConvertible {
    private let method: HTTPMethod
    private let baseURL: String
    private let endpoint: String
    
    // MARK: - Initializers
    
    init(method: HTTPMethod, baseURL: String, endpoint: String) {
        self.method = method
        self.baseURL = baseURL
        self.endpoint = endpoint
    }
}

extension Route {
    public func asURLRequest() throws -> URLRequest {
        guard var url = URL(string: baseURL) else {
            throw RouteError.invalidURL
        }
        
        url = url.appendingPathComponent(endpoint)
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 10
        
        return request
    }
}
