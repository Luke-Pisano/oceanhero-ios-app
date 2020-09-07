//
//  APIServiceError.swift
//  Core
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

public enum APIServiceError: Error {
    case serverError
    case cancelled
    case noInternetConnection
    case missingData
    case missingJSON
    case missingHTTPCode
}
