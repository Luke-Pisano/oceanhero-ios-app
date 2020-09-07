//
//  XCTestCase+Helpers.swift
//  UnitTests
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

@testable import OceanHero
import XCTest

extension XCTestCase {
    func waitForExpectationsWithAssertion(timeout: TimeInterval = 3.0) {
        waitForExpectations(timeout: timeout) { _ in }
    }
    
    func fullfillExpectation(_ expectation: XCTestExpectation, actualError: Error, expectedError: Error) {
        expectation.fulfill()
        XCTAssertEqual(actualError.localizedDescription, expectedError.localizedDescription, "Error should be correct type error")
    }
}
