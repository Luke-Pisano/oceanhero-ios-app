//
//  WKWebView+Cookies.swift
//  Core
//
//  Created by Mariusz on 16/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {
    private var httpCookieStore: WKHTTPCookieStore {
        return WKWebsiteDataStore.default().httpCookieStore
    }

    public func getCookies(for domain: String? = nil, completion: @escaping ([String: Any]) -> Void) {
        var cookieDict = [String: AnyObject]()
        
        httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                if let domain = domain {
                    if cookie.domain.contains(domain) {
                        cookieDict[cookie.name] = cookie.properties as AnyObject?
                    }
                } else {
                    cookieDict[cookie.name] = cookie.properties as AnyObject?
                }
            }
            
            completion(cookieDict)
        }
    }
}
