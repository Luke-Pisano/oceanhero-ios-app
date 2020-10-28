//
//  SearchProvider.swift
//  DuckDuckGo
//
//  Created by Mariusz on 20/10/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import UIKit

public enum SearchProvider: Int {
    case oceanHero
    case microsoft
    case google
    case yahoo
}

extension SearchProvider {
    public var host: String {
        switch self {
        case .oceanHero:
            return "oceanhero.today"
        case .microsoft:
            return "bing.com"
        case .google:
            return "google.com"
        case .yahoo:
            return "yahoo.com"
        }
    }
    
    public var base: String {
        return ProcessInfo.processInfo.environment["BASE_URL", default: "https://\(host)"]
    }
    
    public var baseSearch: String {
        switch self {
        case .oceanHero:
            return "\(base)/web"
        case .microsoft:
            return "\(base)/search"
        case .google:
            return"\(base)/search"
        case .yahoo:
            return "https://search.\(host)/search"
        }
    }
    
    public var searchParam: String {
        switch self {
        case .oceanHero:
            return "q"
        case .microsoft:
            return "q"
        case .google:
            return"q"
        case .yahoo:
            return "p"
        }
    }
    
    public var autocomplete: String {
        switch self {
        case .oceanHero:
            return "https://api.\(host)/suggestions"
        case .microsoft:
            return "\(base)/osjson.aspx?"
        case .google:
            return "\(base)/complete/search"
        case .yahoo:
            return "https://search.\(host)/sugg/chrome"
        }
    }

    public var autocompleteParam: String {
        switch self {
        case .oceanHero:
            return "q"
        case .microsoft:
            return "query"
        case .google:
            return"q"
        case .yahoo:
            return "command"
        }
    }
    
    public var additionalAutocompleteParams: [String: String]? {
        switch self {
        case .oceanHero:
            return nil
        case .microsoft:
            return nil
        case .google:
            return ["client": "chrome"]
        case .yahoo:
            return ["output": "fxjson"]
        }
    }
}
