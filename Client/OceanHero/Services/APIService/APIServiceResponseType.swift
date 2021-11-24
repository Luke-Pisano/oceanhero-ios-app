//
//  APIServiceResponseType.swift
//  Core
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

public protocol APIServiceResponseType {
    var responseData: Data { get }
    var httpResponseStatusCode: Int { get }
}

public class APIServiceResponse: APIServiceResponseType {
    public let responseData: Data
    public let httpResponseStatusCode: Int
    
    // MARK: - Initializers
    
    public init(data responseData: Data, statusCode httpResponseStatusCode: Int) {
        self.responseData = responseData
        self.httpResponseStatusCode = httpResponseStatusCode
    }
}
