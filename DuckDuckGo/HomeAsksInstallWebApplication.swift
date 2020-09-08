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
    
    private(set) var shouldDisplay: Bool = false
    
    var onChangedState: ((HomeAsksInstallWebApplicationState) -> Void)?
    var onClose: (() -> Void)?
    var onHadProblem: (() -> Void)?
    
    private struct Constants {
        static let maxCount: Int = 3
        static let firstStep: Int = 2
        static let nextStep: Int = 10
        static let remindStep: Int = 7
    }
    
    private(set) var currentState: HomeAsksInstallWebApplicationState = .doYouUseOceanHero {
        didSet {
            guard currentState != oldValue else {
                return
            }
            
            appConfiguration.homeAsksInstallWebApplicationState = currentState.rawValue
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
        updateShouldDisplay()
    }
}

extension HomeAsksInstallWebApplication {
    func updateShouldDisplay() {
        updateState()
        
        print("1. count: \(count) currentState: \(currentState.rawValue) lastVisit: \(String(describing: lastVisit)) shouldDisplay: \(shouldDisplay)")
        
        guard let date = lastVisit else {
            lastVisit = Date()
            return
        }
        
        let daysFrom = date.daysFrom(date: Date())
        
        print("2. daysFrom: \(daysFrom) count: \(count) currentState: \(currentState.rawValue) lastVisit: \(date) shouldDisplay: \(shouldDisplay)")
        
        if count >= Constants.maxCount {
            shouldDisplay = false
        } else if count == 0 && daysFrom >= Constants.firstStep { // first steps
            shouldDisplay = true
        } else if count >= 1 && daysFrom >= Constants.remindStep && currentState == .rightTimeToGetOceanHero { // rightTimeToGetOceanHero
            shouldDisplay = true
        } else if count >= 1 && daysFrom >= Constants.nextStep { // second / third steps
            shouldDisplay = true
        }
        
        print("3. daysFrom: \(daysFrom) count: \(count) currentState: \(currentState.rawValue) lastVisit: \(date) shouldDisplay: \(shouldDisplay)")
    }
    
    private func updateState() {
        let state =  HomeAsksInstallWebApplicationState(value: appConfiguration.homeAsksInstallWebApplicationState)
        
        if state == .remindYouSomeOtherTime {
            currentState = .rightTimeToGetOceanHero
        } else {
            currentState = .doYouUseOceanHero
        }
    }
}

extension HomeAsksInstallWebApplication {
    private func installedIt() {
        count = Constants.maxCount
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
            break
        case .remindYouSomeOtherTime:
            // If user clicked Please don't, remind user again in 10 days. But after 2 attempts, never show again
            installedIt()
            onClose?()
        case .willSeeButton:
            // Show form: https://forms.gle/WvuPoRMLxHThCH6B6
            shouldDisplay = false
            onClose?()
        case .rightTimeToGetOceanHero:
            // If user clicked sorry, but no, remind user again in 10 days. But after 2 attempts, never show again
            count += 1
            shouldDisplay = false
            onClose?()
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
            count += 1
            shouldDisplay = false
            onClose?()
        case .willSeeButton:
            //Close dialogue if user clicks “Cool i installed it
            installedIt()
            onClose?()
        case .rightTimeToGetOceanHero:
            currentState = .itIsVeryEasyVisitOceanhero
        }
        
        print("5. count: \(count) currentState: \(currentState.rawValue) lastVisit: \(String(describing: lastVisit)) shouldDisplay: \(shouldDisplay)")
    }
}
