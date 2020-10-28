//
//  SearchProviderUserDefaults.swift
//  Core
//
//  Created by Mariusz on 20/10/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

public class SearchProviderUserDefaults: SearchProviderStore {
    private let groupName: String

    private struct Keys {
        static let searchProvider = "browser.oceanhero.app.searchProvider"
    }

    private var userDefaults: UserDefaults? {
        return UserDefaults(suiteName: groupName)
    }
    
    // MARK: - Initialization

    public init() {
        self.groupName = "\(Global.groupIdPrefix).searchProvider"
    }

    public init(groupName: String) {
        self.groupName = groupName
    }
}

extension SearchProviderUserDefaults {
    public var searchProvider: Int {
        get {
            return userDefaults?.integer(forKey: Keys.searchProvider) ?? 0
        }
        set {
            userDefaults?.setValue(newValue, forKey: Keys.searchProvider)
        }
    }
}
