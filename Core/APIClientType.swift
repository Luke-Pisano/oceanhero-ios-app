//
//  APIClientType.swift
//  Core
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

public typealias APICompletionSuccess = () -> Void
public typealias APICompletionFailure = (APIClientError) -> Void

public protocol APIClientType {
    func request<T: Decodable>(routerType: RouterType, onSuccess: @escaping (T) -> Void, onFailure: @escaping APICompletionFailure) -> URLSessionTask?
}
