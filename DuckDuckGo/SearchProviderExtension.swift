//
//  SearchProviderExtension.swift
//  DuckDuckGo
//
//  Created by Mariusz on 20/10/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation
import Core

extension SearchProvider {
    var title: String {
        switch self {
        case .oceanHero:
            return UserText.searchProviderOceanHeroTitle
        case .microsoft:
            return UserText.searchProviderMicrosoftTitle
        case .google:
            return UserText.searchProviderGoogleTitle
        case .yahoo:
            return UserText.searchProviderYahooTitle
        }
    }
    
    var icon: UIImage {
        switch self {
        case .oceanHero:
            return #imageLiteral(resourceName: "searchProvider_Oceanhero")
        case .microsoft:
            return #imageLiteral(resourceName: "searchProvider_Microsoft")
        case .google:
            return #imageLiteral(resourceName: "searchProvider_Google")
        case .yahoo:
            return #imageLiteral(resourceName: "searchProvider_Yahoo")
        }
    }
    
    var size: CGFloat {
        switch self {
        case .oceanHero:
            return 30.0
        case .microsoft:
            return 22.0
        case .google:
            return 21.0
        case .yahoo:
            return 25.0
        }
    }
}
