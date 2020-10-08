//
//  HomeAsksInstallWebApplication.swift
//  DuckDuckGo
//
//  Created by Mariusz on 07/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import UIKit
import Core

class HomeAsksInstallWebApplication {
    private var appConfiguration: AppConfigurationHomeAsksInstallWebApplication
    
    var onChangedState: ((HomeAsksInstallWebApplicationState) -> Void)?
    var onShow: (() -> Void)?
    var onHide: (() -> Void)?
    
    private struct Constants {
        static let maxCount: Int = 3
        static let firstStep: Int = 2
        static let nextStep: Int = 10
        static let remindStep: Int = 7
    }
    
    private(set) var shouldDisplay: Bool = false {
        didSet {
            guard shouldDisplay != oldValue else {
                return
            }
            
            if shouldDisplay {
                onShow?()
            } else {
                onHide?()
            }
        }
    }
    
    private(set) var currentState: HomeAsksInstallWebApplicationState = .doYouUseOceanHero {
        didSet {
            guard currentState != oldValue else {
                return
            }
            
            appConfiguration.homeAsksInstallWebApplicationState = currentState.rawValue
            
            guard currentState != .rightTimeToGetOceanHero else {
                return
            }
            
            onChangedState?(currentState)
        }
    }
    
    private var count: Int {
        get {
            appConfiguration.homeAsksInstallWebApplicationCount
        }
        set {
            lastVisit = Date()
            appConfiguration.homeAsksInstallWebApplicationCount = newValue
        }
    }
    
    private var lastVisit: Date? {
        get {
            appConfiguration.homeAsksInstallWebApplicationLastVisit
        }
        set {
            guard let date = newValue else {
                return
            }
            
            appConfiguration.homeAsksInstallWebApplicationLastVisit = date
        }
    }
    
    init(appConfiguration: AppConfigurationHomeAsksInstallWebApplication) {
        self.appConfiguration = appConfiguration
        
        updateState()
        updateShouldDisplay()
    }
}

extension HomeAsksInstallWebApplication {
    private func updateState() {
        let state =  HomeAsksInstallWebApplicationState(value: appConfiguration.homeAsksInstallWebApplicationState)
        
        if state == .rightTimeToGetOceanHero {
            currentState = .rightTimeToGetOceanHero
        } else {
            currentState = .doYouUseOceanHero
        }
    }
    
    func updateShouldDisplay() {
        guard let date = lastVisit else {
            lastVisit = Date()
            return
        }
        
        let daysFrom = date.daysFrom(date: Date())
        shouldDisplay = getShouldDisplay(for: daysFrom)
    }
    
    private func getShouldDisplay(for days: Int) -> Bool {
        if count >= Constants.maxCount {
            return false
        } else if count == 0 && days >= Constants.firstStep && currentState != .rightTimeToGetOceanHero { // first steps
            return true
        } else if count >= 0 && days >= Constants.remindStep && currentState == .rightTimeToGetOceanHero { // rightTimeToGetOceanHero
            return true
        } else if count >= 0 && days >= Constants.nextStep { // second / third steps
            return true
        }
        
        return false
    }
}

extension HomeAsksInstallWebApplication {
    private func finalAction() {
        lastVisit = Date()
        count = Constants.maxCount
        shouldDisplay = false
    }
    
    private func waitForNextAction() {
        count += 1
        shouldDisplay = false
    }
}

extension HomeAsksInstallWebApplication {
    func nextLeftAction() {
        switch currentState {
        case .doYouUseOceanHero:
            lastVisit = Date()
            count = Constants.maxCount
            currentState = .success
        case .wouldYouMindTryingIt:
            currentState = .remindYouSomeOtherTime
        case .itIsVeryEasyVisitOceanhero:
            fatalError("The left action shouldn't happen on the itIsVeryEasyVisitOceanhero state")
        case .remindYouSomeOtherTime:
            // If user clicked Please don't, remind user again in 10 days. But after 2 attempts, never show again
            finalAction()
        case .willSeeButton:
            // Show form: https://forms.gle/WvuPoRMLxHThCH6B6
            UIApplication.shared.open(AppUrls().problemOceanHeroComputer)
            finalAction()
        case .rightTimeToGetOceanHero:
            // If user clicked sorry, but no, remind user again in 10 days. But after 2 attempts, never show again
            waitForNextAction()
        case .success:
            fatalError("The left action shouldn't happen on the success state")
        }
    }
    
    func nextRightAction() {
        switch currentState {
        case .doYouUseOceanHero:
            currentState = .wouldYouMindTryingIt
        case .wouldYouMindTryingIt:
            currentState = .itIsVeryEasyVisitOceanhero
        case .itIsVeryEasyVisitOceanhero:
            currentState = .willSeeButton
        case .remindYouSomeOtherTime:
            // wait 7 days and next
            lastVisit = Date()
            currentState = .rightTimeToGetOceanHero
            shouldDisplay = false
        case .willSeeButton:
            //Close dialogue if user clicks “Cool i installed it
            lastVisit = Date()
            count = Constants.maxCount
            currentState = .success
        case .rightTimeToGetOceanHero:
            currentState = .itIsVeryEasyVisitOceanhero
        case .success:
            finalAction()
        }
    }
}
