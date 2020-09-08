//
//  AppConfigurationHomeAsksInstallWebApplication.swift
//  DuckDuckGo
//
//  Created by Mariusz on 07/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

protocol AppConfigurationHomeAsksInstallWebApplication {
    var homeAsksInstallWebApplicationLastVisit: Date? { get set }
    var homeAsksInstallWebApplicationState: Int { get set }
    var homeAsksInstallWebApplicationCount: Int { get set }
}
