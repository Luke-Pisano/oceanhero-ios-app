//
//  APIClientError.swift
//  Core
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

public enum APIClientError: LocalizedError {
    case parsingError(error: Error)
    case parsingImageError
    case wrongResponseFormat
    case noInternetConnection
    case notRecognizedServerError
    case unauthorized
    case cancelled
    case incorectLoginPasswordOrToken
    case objectNotFound
    case internalServerError
    case badRequest
    case recognizedServerError(code: Int)
    
    // MARK: - Initializers
    
    public init(with serviceError: APIServiceError) {
        switch serviceError {
        case .missingData, .missingHTTPCode, .missingJSON:
            self = .wrongResponseFormat
        case .noInternetConnection:
            self = .noInternetConnection
        case .serverError:
            self = .notRecognizedServerError
        case .cancelled:
            self = .cancelled
        }
    }
    
    public init(with parserError: APIParserError) {
        switch parserError {
        case .parsingError(let error):
            self = .parsingError(error: error)
        case let .serverError(codeError):
            self.init(with: codeError)
        }
    }
    
    private init(with statusCodeError: APIStatusCodeError) {
        switch statusCodeError {
        case .unauthorized:
            self = .unauthorized
        case .forbiddenAccess:
            self = .incorectLoginPasswordOrToken
        case .notFound:
            self = .objectNotFound
        case .notRecognized(let code):
            self = .recognizedServerError(code: code)
        case .internalServerError:
            self = .internalServerError
        case .badRequest:
            self = .badRequest
        }
    }
}

extension APIClientError {
    public var errorDescription: String? {
        switch self {
        case .parsingError:
            return ""
        case .wrongResponseFormat:
            return ""
        case .noInternetConnection:
            return ""
        case .notRecognizedServerError:
            return ""
        case .unauthorized:
            return ""
        case .incorectLoginPasswordOrToken:
            return ""
        case .objectNotFound:
            return ""
        case .recognizedServerError(let code):
            return "\(code)"
        case .cancelled:
            return ""
        case .parsingImageError:
            return ""
        case .internalServerError:
            return ""
        case .badRequest:
            return ""
        }
    }
}
