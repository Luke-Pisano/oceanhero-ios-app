//
//  DateExtension.swift
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

import Foundation

extension Date {
    public func isSameDay(_ otherDate: Date?) -> Bool {
        guard let otherDate = otherDate else { return false }
        return Calendar.current.isDate(self, inSameDayAs: otherDate)
    }
}

extension Date {
    public func daysFrom(date: Date) -> Int {
        let calendar = Calendar.current
        
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        guard let days = components.day else {
            return 0
        }
        
        return days
    }
}
