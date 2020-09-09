//
//  HomeAsksInstallWebApplicationTests.swift
//  DuckDuckGo
//
//  Created by Mariusz on 08/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation
import XCTest
@testable import Core
@testable import OceanHero

class HomeAsksInstallWebApplicationTests: XCTestCase {
    private var appUserDefaults: AppUserDefaultsHomeAsksInstallWebApplication!
    private var sut: HomeAsksInstallWebApplication!
    
    override func setUp() {
        super.setUp()
        
        appUserDefaults = AppUserDefaultsHomeAsksInstallWebApplication()
        sut = HomeAsksInstallWebApplication(appConfiguration: appUserDefaults)
    }

    override func tearDown() {
        appUserDefaults = nil
        sut = nil
        
        super.tearDown()
    }
    
    func testWhenYouRunApp() {
        XCTAssertTrue(sut.currentState == .doYouUseOceanHero)
        XCTAssertTrue(sut.shouldDisplay == false)
        
        sut.updateShouldDisplay()
        
        XCTAssertTrue(sut.currentState == .doYouUseOceanHero)
        XCTAssertTrue(sut.shouldDisplay == false)
    }
    
    func testWhenYouRunFirstTimeFromTheLastVisit() {
        XCTAssertTrue(sut.currentState == .doYouUseOceanHero)
        XCTAssertTrue(sut.shouldDisplay == false)
        
        appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        sut.updateShouldDisplay()
        
        XCTAssertTrue(sut.currentState == .doYouUseOceanHero)
        XCTAssertTrue(sut.shouldDisplay == false)
        
        appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        sut.updateShouldDisplay()
        
        XCTAssertTrue(sut.currentState == .doYouUseOceanHero)
        XCTAssertTrue(sut.shouldDisplay == true)
        
        appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: -3, to: Date())
        sut.updateShouldDisplay()
        
        XCTAssertTrue(sut.currentState == .doYouUseOceanHero)
        XCTAssertTrue(sut.shouldDisplay == true)
    }
    
    func testWhenYouRunMoreThatThreeTimesYouDontShouldDisplay() {
        var day = -2
        var count = 0
        var shouldDisplay = true
        
        for i in 0..<4 {
            if i > 2 {
                shouldDisplay = false
            }
            
            appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: day, to: Date())
            sut.updateShouldDisplay()
            
            XCTAssertTrue(sut.currentState == .doYouUseOceanHero)
            XCTAssertTrue(sut.shouldDisplay == shouldDisplay)
            XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, count)
            
            sut.nextRightAction()
            XCTAssertTrue(sut.currentState == .wouldYouMindTryingIt)
            XCTAssertTrue(sut.shouldDisplay == shouldDisplay)
            XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, count)
            
            sut.nextRightAction()
            XCTAssertTrue(sut.currentState == .itIsVeryEasyVisitOceanhero)
            XCTAssertTrue(sut.shouldDisplay == shouldDisplay)
            XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, count)
            
            sut.nextRightAction()
            XCTAssertTrue(sut.currentState == .willSeeButton)
            XCTAssertTrue(sut.shouldDisplay == shouldDisplay)
            XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, count)
            
            sut.nextLeftAction()
            count += 1
            XCTAssertTrue(sut.currentState == .willSeeButton)
            XCTAssertTrue(sut.shouldDisplay == false)
            XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, count)
            
            day -= 10
        }
    }
}

extension HomeAsksInstallWebApplicationTests {
    func testWhenUseNextLeftActionThenChangeCurrentStatus() {
        var changedStateCount = 0
        var currentState: HomeAsksInstallWebApplicationState = .wouldYouMindTryingIt
        
        appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        sut.updateShouldDisplay()
        
        sut.onChangedState = { state in
            changedStateCount += 1
            XCTAssertTrue(state == currentState)
        }
        
        sut.nextLeftAction()
        XCTAssertTrue(sut.shouldDisplay == true)
        
        currentState = .remindYouSomeOtherTime
        sut.nextLeftAction()
        XCTAssertTrue(sut.shouldDisplay == true)
        
        sut.nextLeftAction()
        XCTAssertTrue(sut.shouldDisplay == false)
        XCTAssertEqual(changedStateCount, 2)
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 3)
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationState, sut.currentState.rawValue)
    }
    
    func testWhenUseNextRightActionThenChangeCurrentStatus() {
        var changedStateCount = 0
        var currentState: HomeAsksInstallWebApplicationState = .wouldYouMindTryingIt
        
        appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        sut.updateShouldDisplay()
        XCTAssertTrue(sut.shouldDisplay == true)
        
        sut.onChangedState = { state in
            changedStateCount += 1
            XCTAssertTrue(state == currentState)
        }
        
        sut.nextRightAction()
        XCTAssertTrue(sut.shouldDisplay == true)
        
        currentState = .itIsVeryEasyVisitOceanhero
        sut.nextRightAction()
        XCTAssertTrue(sut.shouldDisplay == true)
        
        currentState = .willSeeButton
        sut.nextRightAction()
        XCTAssertTrue(sut.shouldDisplay == true)
        
        currentState = .willSeeButton
        sut.nextRightAction()
        
        XCTAssertTrue(sut.shouldDisplay == false)
        XCTAssertEqual(changedStateCount, 3)
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 3)
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationState, sut.currentState.rawValue)
    }
}

extension HomeAsksInstallWebApplicationTests {
    func testWhenUseNextLeftActionThenCoutIsCorrect() {
        appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        sut.updateShouldDisplay()

        sut.nextLeftAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        
        sut.nextLeftAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        
        sut.nextLeftAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 3)
    }
    
    func testWhenUseNextRightActionThenCoutIsCorrect() {
        appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        sut.updateShouldDisplay()

        sut.nextRightAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        
        sut.nextRightAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        
        sut.nextRightAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        
        sut.nextRightAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 3)
    }
    
    func testWhenUseNextLeftAndRightActionThenCoutIsCorrect() {
        appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        sut.updateShouldDisplay()

        sut.nextLeftAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == true)
        
        sut.nextLeftAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == true)
        
        sut.nextRightAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == false)
    }
    
    func testWhenUseNextRightAndLeftActionThenCoutIsCorrect() {
        appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        sut.updateShouldDisplay()

        sut.nextRightAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == true)
        
        sut.nextRightAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == true)
        
        sut.nextRightAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == true)
        
        sut.nextLeftAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 1)
        XCTAssertTrue(sut.shouldDisplay == false)
    }
    
    func testWhenRemindYouSomeOtherTimeUseNextRightActionThenCoutIsCorrect() {
        appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        sut.updateShouldDisplay()

        sut.nextLeftAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == true)
        
        sut.nextLeftAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == true)
        
        sut.nextRightAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == false)
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationState, HomeAsksInstallWebApplicationState.rightTimeToGetOceanHero.rawValue)
        
        appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: -6, to: Date())
        sut.updateShouldDisplay()
        
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == false)
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationState, HomeAsksInstallWebApplicationState.rightTimeToGetOceanHero.rawValue)
        
        appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        sut.updateShouldDisplay()
        
        XCTAssertTrue(sut.shouldDisplay == true)
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationState, HomeAsksInstallWebApplicationState.rightTimeToGetOceanHero.rawValue)
        
        sut.nextRightAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == true)
        
        sut.nextRightAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == true)
        
        sut.nextRightAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 3)
        XCTAssertTrue(sut.shouldDisplay == false)
    }
    
    func testWhenRemindYouSomeOtherTimeUseNextLeftActionThenCoutIsCorrect() {
        appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        sut.updateShouldDisplay()

        sut.nextLeftAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == true)
        
        sut.nextLeftAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == true)
        
        sut.nextRightAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == false)
        
        appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: -6, to: Date())
        sut.updateShouldDisplay()
        
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertTrue(sut.shouldDisplay == false)
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationState, HomeAsksInstallWebApplicationState.rightTimeToGetOceanHero.rawValue)
        
        appUserDefaults.homeAsksInstallWebApplicationLastVisit = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        sut.updateShouldDisplay()
        
        XCTAssertTrue(sut.shouldDisplay == true)
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 0)
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationState, HomeAsksInstallWebApplicationState.rightTimeToGetOceanHero.rawValue)
        
        sut.nextLeftAction()
        XCTAssertEqual(appUserDefaults.homeAsksInstallWebApplicationCount, 1)
        XCTAssertTrue(sut.shouldDisplay == false)
    }
}

class AppUserDefaultsHomeAsksInstallWebApplication: AppConfigurationHomeAsksInstallWebApplication {
    var homeAsksInstallWebApplicationLastVisit: Date?
    var homeAsksInstallWebApplicationState: Int = 0
    var homeAsksInstallWebApplicationCount: Int = 0
}
