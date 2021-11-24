//
//  APIServiceType.swift
//  Core
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

public typealias APIServiceSuccess = (APIServiceResponseType) -> Void
public typealias APIServiceFailure = (APIServiceError) -> Void

public protocol APIServiceType {
    func request(type: RouterType, onSuccess: @escaping APIServiceSuccess, onFailure: @escaping APIServiceFailure) -> URLSessionTask?
}
