//
//  SearchCounterUserScript.swift
//  Core
//
//  Created by Mariusz Graczkowski on 28/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import WebKit
import os

public class SearchCounterUserScript: NSObject, UserScript {
    public var source: String = ""
    
    struct MessageNames {
        static let didUpdateSearchCounter = "didUpdateSearchCounter"
    }
    
    public var didUpdateSearchCounter: ((Int) -> Void)?
    
    public var injectionTime: WKUserScriptInjectionTime = .atDocumentStart
    
    public var forMainFrameOnly: Bool = false
    
    public var messageNames: [String] = [ MessageNames.didUpdateSearchCounter ]

    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
            
        case MessageNames.didUpdateSearchCounter:
            guard let array = message.body as? [String: Any],
                let key = array["key"] as? String,
                key == "searchCounter",
                let value = array["value"] as? Int else {
                return
            }
            
            os_log("didUpdateSearchCounter: %s", log: generalLog, type: .debug, String(describing: message.body))
            didUpdateSearchCounter?(value)
            
        default: break
        }
    }
}
