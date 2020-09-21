//
//  APIParser.swift
//  Core
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation
import UIKit

public class APIParser: APIParserType {
    private func checkReponseCode(_ code: Int) throws {
        switch code {
        case 200..<300:
            break
        default:
            throw APIStatusCodeError(code: code)
        }
    }
    
    public init() {}
    
    public func parse<T: Decodable>(response: APIServiceResponseType, onSuccess: @escaping (T) -> Void,
                                    onFailure: @escaping (APIParserError) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            self.parse(response: response, onSuccess: {
                do {
                    let object = try JSONDecoder.APIDecoder.decode(T.self, from: response.responseData)
                    onSuccess(object)
                } catch {
                    onFailure(.parsingError(error: error))
                    return
                }
            }, onFailure: onFailure)
        }
    }
    
    private func parse(response: APIServiceResponseType, onSuccess: @escaping () -> Void,
                       onFailure: @escaping (APIParserError) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            do {
                try self.checkReponseCode(response.httpResponseStatusCode)
            } catch let statusCodeError as APIStatusCodeError {
                onFailure(APIParserError.serverError(statusCode: statusCodeError))
                return
            } catch {
                onFailure(.parsingError(error: error))
                return
            }
            
            onSuccess()
        }
    }
}
