//
//  HomeAsksInstallWebApplicationState.swift
//  DuckDuckGo
//
//  Created by Mariusz on 07/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

enum HomeAsksInstallWebApplicationState: Int {
    // Do you use OceanHero on your computer ( Yes - Not yet )
    case doYouUseOceanHero = 0
    // Would you mind trying it out on your computer? ( Maybe later - Sure, let’s do it now )
    case wouldYouMindTryingIt = 1
    // Ok, it is very easy. Visit oceanhero.today on your computer ( Ok, I am on it )
    case itIsVeryEasyVisitOceanhero = 2
    // No problem! I’ll remind you some other time ( Please don’t - Sure )
    case remindYouSomeOtherTime = 3
    // Great! Now, you will see a button that asks you to install our extension ( I had a problem - Cool, I installed it )
    case willSeeButton = 4
    // Hello friend, is now the right time to get OceanHero set up on your computer? ( Sorry, but no - Yes, let’s do it )
    case rightTimeToGetOceanHero = 5
    
    init(value: Int) {
        self = HomeAsksInstallWebApplicationState(rawValue: value) ?? .doYouUseOceanHero
        print("HomeAsksInstallWebApplicationState: \(value) self: \(self.rawValue)")
    }
}

extension HomeAsksInstallWebApplicationState {
    var title: String {
        switch self {
        case .doYouUseOceanHero:
            return "Do you use OceanHero on your computer"
        case .wouldYouMindTryingIt:
            return "Would you mind trying it out on your computer?"
        case .itIsVeryEasyVisitOceanhero:
            return "Ok, it is very easy. Visit oceanhero.today on your computer"
        case .remindYouSomeOtherTime:
            return "No problem! I’ll remind you some other time"
        case .willSeeButton:
            return "Great! Now, you will see a button that asks you to install our extension"
        case .rightTimeToGetOceanHero:
            return "Hello friend, is now the right time to get OceanHero set up on your computer?"
        }
    }
    
    var leftButtonTitle: String? {
        switch self {
        case .doYouUseOceanHero:
            return "Yes"
        case .wouldYouMindTryingIt:
            return "Maybe later"
        case .itIsVeryEasyVisitOceanhero:
            return nil
        case .remindYouSomeOtherTime:
            return "Please don’t"
        case .willSeeButton:
            return "I had a problem"
        case .rightTimeToGetOceanHero:
            return "Sorry, but no"
        }
    }
    
    var rightButtonTitle: String {
        switch self {
        case .doYouUseOceanHero:
            return "Not yet"
        case .wouldYouMindTryingIt:
            return "Sure, let’s do it now"
        case .itIsVeryEasyVisitOceanhero:
            return "Ok, I am on it"
        case .remindYouSomeOtherTime:
            return "Sure"
        case .willSeeButton:
            return "Cool, I installed it"
        case .rightTimeToGetOceanHero:
            return "Yes, let’s do it"
        }
    }
}
