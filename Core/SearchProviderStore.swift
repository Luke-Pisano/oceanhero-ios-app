//
//  SearchProviderStore.swift
//  Core
//
//  Created by Mariusz on 20/10/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

public protocol SearchProviderStore {
    var searchProvider: Int { get set }
}
