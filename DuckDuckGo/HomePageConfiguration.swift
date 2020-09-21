//
//  HomePageConfiguration.swift
//  DuckDuckGo
//
//  Copyright © 2018 DuckDuckGo. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
import Core

class HomePageConfiguration {
    enum ConfigName: Int {
        case simple
        case centerSearch
        case centerSearchAndFavorites
    }
    
    enum Component: Equatable {
        case navigationBarSearch(fixed: Bool)
        case centeredSearch(fixed: Bool)
        case extraContent
        case asksInstallWebApplication
        case user
        case favorites
        case padding
    }
    
    let settings: HomePageSettings
    
    private(set) var components = [Component]()
    
    init(settings: HomePageSettings = DefaultHomePageSettings()) {
        self.settings = settings
    }
}

extension HomePageConfiguration {
    func isComponent(_ component: Component) -> Bool {
        return components.first { $0 == component } != nil
    }
    
    func index(for component: Component) -> Int? {
        return components.firstIndex { $0 == component }
    }
}

extension HomePageConfiguration {
    func add(component: Component, section: Int) {
        components.insert(component, at: section)
    }
    
    func remove(component: Component) {
        guard let index = index(for: component) else {
            return
        }
        
        components.remove(at: index)
    }
}

extension HomePageConfiguration {
    func components(asksInstallWebApplication: HomeAsksInstallWebApplication, isLoggedIn: Bool,
                    bookmarksManager: BookmarksManager = BookmarksManager()) -> [Component] {
        // turn on scrolling
        let fixed = false//!settings.favorites || bookmarksManager.favoritesCount == 0

        components = [Component]()
        
        switch settings.layout {
        case .navigationBar:
            components.append(.navigationBarSearch(fixed: fixed))
        case .centered:
            components.append(.centeredSearch(fixed: fixed))
        }

        // Add extra content renderer here if needed
        
        if asksInstallWebApplication.shouldDisplay {
            components.append(.asksInstallWebApplication)
        }
        
        if !isLoggedIn {
            components.append(.user)
        }
        
        if settings.favorites {
            components.append(.favorites)
            
//            if settings.layout == .centered {
//                components.append(.padding)
//            }
        }

        return components
    }
}
