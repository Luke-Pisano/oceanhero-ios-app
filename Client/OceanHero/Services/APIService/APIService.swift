//
//  APIService.swift
//  Core
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Alamofire
import Foundation

public class APIService: APIServiceType {
    private(set) var router: Router
        
    // MARK: - Initializers
    
    public init(baseURL: String) {
        self.router = Router(baseURL: baseURL)
    }
    
    @discardableResult
    func makeRequest(using route: Route, onSuccess: @escaping APIServiceSuccess, onFailure: @escaping APIServiceFailure) -> URLSessionTask? {
      return AF.request(route).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.value else {
                    onFailure(.missingData)
                    return
                }
                guard let httpStatusCode = response.response?.statusCode else {
                    onFailure(.missingHTTPCode)
                    return
                }
                
                let response = APIServiceResponse(data: data, statusCode: httpStatusCode)
                onSuccess(response)
            case .failure(let error):
                guard error._code != NSURLErrorCancelled else {
                    onFailure(.cancelled)
                    return
                }
                
                guard error._code == NSURLErrorTimedOut
                    || error._code == NSURLErrorNotConnectedToInternet
                    || error._code == NSURLErrorNetworkConnectionLost else {
                        onFailure(.serverError)
                        return
                }
                
                onFailure(.noInternetConnection)
            }
        }.task
    }
    
    public func request(type: RouterType, onSuccess: @escaping APIServiceSuccess, onFailure: @escaping APIServiceFailure) -> URLSessionTask? {
        return makeRequest(using: Route(method: type.method, baseURL: self.router.baseURL, endpoint: type.endpoint),
                           onSuccess: onSuccess, onFailure: onFailure)
    }
}
