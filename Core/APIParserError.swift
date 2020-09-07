//
//  APIParserError.swift
//  Core
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

public enum APIParserError: Error {
    case serverError(statusCode: APIStatusCodeError)
    case parsingError(error: Error)
}

public enum APIStatusCodeError: Error {
    case unauthorized
    case forbiddenAccess
    case notFound
    case notRecognized(code: Int)
    case internalServerError
    case badRequest
    
    // MARK: - Initializers
    
    init(code: Int) {
        switch code {
        case 401:
            self = .unauthorized
        case 403:
            self = .forbiddenAccess
        case 404:
            self = .notFound
        case 400:
            self = .badRequest
        case 500:
            self = .internalServerError
        case let code:
            self = .notRecognized(code: code)
        }
    }
}
