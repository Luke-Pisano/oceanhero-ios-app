//
//  DateFormatter+Formatters.swift
//  Core
//
//  Created by Mariusz on 21/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

public extension DateFormatter {
    //2020-09-21T12:11:13+0000
    static let APIFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        return dateFormatter
    }()
}
