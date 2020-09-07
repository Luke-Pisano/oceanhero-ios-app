//
//  APIClientTests.swift
//  DuckDuckGo
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation
import XCTest
@testable import OceanHero
import Core

class APIClientTests: XCTestCase {
    var sut: APIClient!
    var apiService: APIServiceType!
    var apiParser: APIParserType!

    override func setUp() {
        super.setUp()
        
        apiService = APIService(baseURL: "")
        apiParser = APIParser()
        sut = APIClient(apiService: apiService, apiParser: apiParser)
    }
    
    override func tearDown() {
        apiService = nil
        apiParser = nil
        sut = nil
        
        super.tearDown()
    }
    
    func testThatInitReturnsProperClass() {
        XCTAssertNotNil(sut.apiService)
        XCTAssertNotNil(sut.apiParser)
    }
}
