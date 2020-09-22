//
//  AuthorizationUserScript.swift
//  Core
//
//  Created by Mariusz on 22/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import WebKit
import os

public class AuthorizationUserScript: NSObject, UserScript {
    public var source: String = ""
    
    struct MessageNames {
        static let loggedIn = "loggedIn"
        static let loggedOut = "loggedOut"
    }
    
    public var didLogin: ((String) -> Void)?
    public var didLogout: (() -> Void)?
    
    public var injectionTime: WKUserScriptInjectionTime = .atDocumentStart
    
    public var forMainFrameOnly: Bool = false
    
    public var messageNames: [String] = [ MessageNames.loggedIn, MessageNames.loggedOut ]

    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
            
        case MessageNames.loggedIn:
            guard let token = message.body as? String else {
                return
            }
            
            os_log("loggedIn: %s", log: generalLog, type: .debug, String(describing: message.body))
            didLogin?(token)
        case MessageNames.loggedOut:
            os_log("loggedOut", log: generalLog, type: .debug)
            didLogout?()
            
        default:
            break
        }
    }
}
