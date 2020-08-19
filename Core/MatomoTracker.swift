//
//  MatomoTracker.swift
//  Core
//
//  Created by Cezary Bielecki on 18/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation
import MatomoTracker

extension MatomoTracker {
    static let shared: MatomoTracker = MatomoTracker(siteId: "2", baseURL: URL(string: "https://analytics.oceanhero.today/matomo.php")!)
}
