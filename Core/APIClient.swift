//
//  ServiceClient.swift
//  Core
//
//  Created by Cezary Bielecki on 18/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Alamofire
import Foundation

public class APIClient: APIClientType {
    public private(set) var apiService: APIServiceType
    public private(set) var apiParser: APIParserType
    
    // MARK: - Initializers
    
    public init(apiService: APIServiceType, apiParser: APIParserType) {
        self.apiService = apiService
        self.apiParser = apiParser
    }
}

extension APIClient {
    public func request<T: Decodable>(routerType: RouterType,
                                      onSuccess: @escaping (T) -> Void,
                                      onFailure: @escaping APICompletionFailure) -> URLSessionTask? {
        return apiService.request(type: routerType, onSuccess: { [unowned self] response in
            self.apiParser.parse(response: response, onSuccess: onSuccess, onFailure: { error in
                onFailure(APIClientError(with: error))
            })
        }, onFailure: { error in
            onFailure(APIClientError(with: error))
        })
    }
}
