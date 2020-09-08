//
//  DateExtensionTests.swift
//  DuckDuckGo
//
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import XCTest

 class DateExtensionTests: XCTestCase {
    func testWhenDatesAreSame() {
        let today: Date = Date()
        let secondDate: Date = Date()
        XCTAssertTrue(today.isSameDay(secondDate))
    }
    
    func testWhenDatesAreNotSame() {
        let today: Date = Date()
        let secondDate: Date? = Calendar.current.date(byAdding: .day, value: -1, to: today)
        XCTAssertFalse(today.isSameDay(secondDate))
    }
    
    func testWhenOtherDateIsNil() {
        let today: Date = Date()
        let secondDate: Date? = nil
        XCTAssertFalse(today.isSameDay(secondDate))
    }

    func testWhenDaysFromDateAreCorrect() {
        let today: Date = Date()
        let nextDay: Date = today.calculateDate(day: 1)
        XCTAssertEqual(today.daysFrom(date: nextDay), 1)
        
        let next5Days: Date = today.calculateDate(day: 5)
        XCTAssertEqual(today.daysFrom(date: next5Days), 5)
        
        let next35Days: Date = today.calculateDate(day: 35)
        XCTAssertEqual(today.daysFrom(date: next35Days), 35)
        
        let next135Days: Date = today.calculateDate(day: 135)
        XCTAssertEqual(today.daysFrom(date: next135Days), 135)
    }
 }

extension Date {
    fileprivate func calculateDate(year: Int = 0, month: Int = 0, day: Int = 0) -> Date {
        let calendar = Calendar.current
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        guard let newDate = calendar.date(byAdding: components, to: self) else {
            fatalError("Unable to find new date")
        }
        
        return newDate
    }
}
