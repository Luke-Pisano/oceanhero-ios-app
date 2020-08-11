//
//  ContentBlockerStringCache.swift
//  DuckDuckGo
//
//  Copyright © 2017 DuckDuckGo. All rights reserved.
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

#warning("There was runtime error of unknown source here, guard added")

public class ContentBlockerStringCache {

    public static func removeLegacyData() {
        let fileManager = FileManager.default
        let groupName = ContentBlockerStoreConstants.groupName

        guard let cacheDir = fileManager.containerURL(forSecurityApplicationGroupIdentifier: groupName) else {
            print("container URL not found")
            return
        }

        try? fileManager.removeItem(atPath: cacheDir.appendingPathComponent("string-cache").path)
    }

}
