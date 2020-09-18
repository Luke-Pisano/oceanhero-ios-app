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
    
    case success = 6
    
    init(value: Int) {
        self = HomeAsksInstallWebApplicationState(rawValue: value) ?? .doYouUseOceanHero
        print("HomeAsksInstallWebApplicationState: \(value) self: \(self.rawValue)")
    }
}

extension HomeAsksInstallWebApplicationState {
    var title: String {
        switch self {
        case .doYouUseOceanHero:
            return UserText.hAIWAStateDoYouUseOceanHeroTitle
        case .wouldYouMindTryingIt:
            return UserText.hAIWAStateStateWouldYouMindTryingItTitle
        case .itIsVeryEasyVisitOceanhero:
            return UserText.hAIWAStateStateItIsVeryEasyVisitOceanheroTitle
        case .remindYouSomeOtherTime:
            return UserText.hAIWAStateStateRemindYouSomeOtherTimeTitle
        case .willSeeButton:
            return UserText.hAIWAStateStateWillSeeButtonTitle
        case .rightTimeToGetOceanHero:
            return UserText.hAIWAStateStateRightTimeToGetOceanHeroTitle
        case .success:
            return UserText.hAIWAStateStateSuccessTitle
        }
    }
    
    var leftButtonTitle: String? {
        switch self {
        case .doYouUseOceanHero:
            return UserText.hAIWAStateDoYouUseOceanHeroLeftButtonTitle
        case .wouldYouMindTryingIt:
            return UserText.hAIWAStateStateWouldYouMindTryingItLeftButtonTitle
        case .itIsVeryEasyVisitOceanhero:
            return nil
        case .remindYouSomeOtherTime:
            return UserText.hAIWAStateStateRemindYouSomeOtherTimeLeftButtonTitle
        case .willSeeButton:
            return UserText.hAIWAStateStateWillSeeButtonLeftButtonTitle
        case .rightTimeToGetOceanHero:
            return UserText.hAIWAStateStateRightTimeToGetOceanHeroLeftButtonTitle
        case .success:
            return nil
        }
    }
    
    var rightButtonTitle: String {
        switch self {
        case .doYouUseOceanHero:
            return UserText.hAIWAStateDoYouUseOceanHeroRightButtonTitle
        case .wouldYouMindTryingIt:
            return UserText.hAIWAStateStateWouldYouMindTryingItRightButtonTitle
        case .itIsVeryEasyVisitOceanhero:
            return UserText.hAIWAStateStateItIsVeryEasyVisitOceanheroRightButtonTitle
        case .remindYouSomeOtherTime:
            return UserText.hAIWAStateStateRemindYouSomeOtherTimeRightButtonTitle
        case .willSeeButton:
            return UserText.hAIWAStateStateWillSeeButtonRightButtonTitle
        case .rightTimeToGetOceanHero:
            return UserText.hAIWAStateStateRightTimeToGetOceanHeroRightButtonTitle
        case .success:
            return UserText.hAIWAStateStateSuccessRightButtonTitle
        }
    }
}
