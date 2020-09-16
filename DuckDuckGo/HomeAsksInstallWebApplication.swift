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
    func updateShouldDisplay() {
        print("1. count: \(count) currentState: \(currentState.rawValue) lastVisit: \(String(describing: lastVisit)) shouldDisplay: \(shouldDisplay)")
        
        guard let date = lastVisit else {
            lastVisit = Date()
            return
        }
        
        let daysFrom = date.daysFrom(date: Date())
        
        print("2. daysFrom: \(daysFrom) count: \(count) currentState: \(currentState.rawValue) lastVisit: \(date) shouldDisplay: \(shouldDisplay)")
        
        if count >= Constants.maxCount {
            shouldDisplay = false
        } else if count == 0 && daysFrom >= Constants.firstStep && currentState != .rightTimeToGetOceanHero { // first steps
            shouldDisplay = true
        } else if count >= 0 && daysFrom >= Constants.remindStep && currentState == .rightTimeToGetOceanHero { // rightTimeToGetOceanHero
            shouldDisplay = true
        } else if count >= 0 && daysFrom >= Constants.nextStep { // second / third steps
            shouldDisplay = true
        } else {
            shouldDisplay = false
        }
        
        print("3. daysFrom: \(daysFrom) count: \(count) currentState: \(currentState.rawValue) lastVisit: \(date) shouldDisplay: \(shouldDisplay)")
    }
    
    private func updateState() {
        let state =  HomeAsksInstallWebApplicationState(value: appConfiguration.homeAsksInstallWebApplicationState)
        
        if state == .rightTimeToGetOceanHero {
            currentState = .rightTimeToGetOceanHero
        } else {
            currentState = .doYouUseOceanHero
        }
    }
}

extension HomeAsksInstallWebApplication {
    private func installedIt() {
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
            currentState = .wouldYouMindTryingIt
        case .wouldYouMindTryingIt:
            currentState = .remindYouSomeOtherTime
        case .itIsVeryEasyVisitOceanhero:
            fatalError("Shouldn't be happens")
        case .remindYouSomeOtherTime:
            // If user clicked Please don't, remind user again in 10 days. But after 2 attempts, never show again
            installedIt()
        case .willSeeButton:
            // Show form: https://forms.gle/WvuPoRMLxHThCH6B6
            UIApplication.shared.open(AppUrls().problemOceanHeroComputer)
        case .rightTimeToGetOceanHero:
            // If user clicked sorry, but no, remind user again in 10 days. But after 2 attempts, never show again
            waitForNextAction()
        }
        
        print("4. count: \(count) currentState: \(currentState.rawValue) lastVisit: \(String(describing: lastVisit)) shouldDisplay: \(shouldDisplay)")
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
            installedIt()
        case .rightTimeToGetOceanHero:
            currentState = .itIsVeryEasyVisitOceanhero
        }
        
        print("5. count: \(count) currentState: \(currentState.rawValue) lastVisit: \(String(describing: lastVisit)) shouldDisplay: \(shouldDisplay)")
    }
}
