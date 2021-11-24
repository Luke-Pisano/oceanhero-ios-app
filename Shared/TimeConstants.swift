/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation

public typealias Timestamp = UInt64
public typealias MicrosecondTimestamp = UInt64

public let ThreeWeeksInSeconds = 3 * 7 * 24 * 60 * 60

public let OneYearInMilliseconds = 12 * OneMonthInMilliseconds
public let OneMonthInMilliseconds = 30 * OneDayInMilliseconds
public let OneWeekInMilliseconds = 7 * OneDayInMilliseconds
public let OneDayInMilliseconds = 24 * OneHourInMilliseconds
public let OneHourInMilliseconds = 60 * OneMinuteInMilliseconds
public let OneMinuteInMilliseconds = 60 * OneSecondInMilliseconds
public let OneSecondInMilliseconds: UInt64 = 1000

fileprivate let rfc822DateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    dateFormatter.dateFormat = "EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'"
    dateFormatter.locale = Locale(identifier: "en_US")
    return dateFormatter
}()

extension TimeInterval {
    public static func fromMicrosecondTimestamp(_ microsecondTimestamp: MicrosecondTimestamp) -> TimeInterval {
        return Double(microsecondTimestamp) / 1000000
    }
}

extension Timestamp {
    public static func uptimeInMilliseconds() -> Timestamp {
        return Timestamp(DispatchTime.now().uptimeNanoseconds) / 1000000
    }
}

extension Date {
    public static func now() -> Timestamp {
        return UInt64(1000 * Date().timeIntervalSince1970)
    }

    public func toMicrosecondTimestamp() -> MicrosecondTimestamp {
        return UInt64(1_000_000 * timeIntervalSince1970)
    }

    public static func nowNumber() -> NSNumber {
        return NSNumber(value: now() as UInt64)
    }

    public static func nowMicroseconds() -> MicrosecondTimestamp {
        return UInt64(1000000 * Date().timeIntervalSince1970)
    }

    public static func fromTimestamp(_ timestamp: Timestamp) -> Date {
        return Date(timeIntervalSince1970: Double(timestamp) / 1000)
    }
    
    public func toTimestamp() -> Timestamp {
        return UInt64(1000 * timeIntervalSince1970)
    }

    public static func fromMicrosecondTimestamp(_ microsecondTimestamp: MicrosecondTimestamp) -> Date {
        return Date(timeIntervalSince1970: Double(microsecondTimestamp) / 1000000)
    }

    public func toRelativeTimeString(dateStyle: DateFormatter.Style = .short, timeStyle: DateFormatter.Style = .short) -> String {
        let now = Date()

        let units: Set<Calendar.Component> = [.second, .minute, .day, .weekOfYear, .month, .year, .hour]
        let components = Calendar.current.dateComponents(units, from: self, to: now)

        if components.year ?? 0 > 0 {
            return String(format: DateFormatter.localizedString(from: self, dateStyle: dateStyle, timeStyle: timeStyle))
        }

        if components.month == 1 {
            return String(format: .TimeConstantMoreThanAMonth)
        }

        if components.month ?? 0 > 1 {
            return String(format: DateFormatter.localizedString(from: self, dateStyle: dateStyle, timeStyle: timeStyle))
        }

        if components.weekOfYear ?? 0 > 0 {
            return String(format: .TimeConstantMoreThanAWeek)
        }

        if components.day == 1 {
            return String(format: .TimeConstantYesterday)
        }

        if components.day ?? 0 > 1 {
            return String(format: .TimeConstantThisWeek, String(describing: components.day))
        }

        if components.hour ?? 0 > 0 || components.minute ?? 0 > 0 {
            // Can't have no time specified for this formatting case.
            let timeStyle = timeStyle != .none ? timeStyle : .short
            let absoluteTime = DateFormatter.localizedString(from: self, dateStyle: .none, timeStyle: timeStyle)
            return String(format: .TimeConstantRelativeToday, absoluteTime)
        }

        return String(format: .TimeConstantJustNow)
    }

    public func toRFC822String() -> String {
        return rfc822DateFormatter.string(from: self)
    }
}

extension Date {
    public static var yesterday: Date { return Date().dayBefore }
    public static var tomorrow: Date { return Date().dayAfter }
    public var lastWeek: Date {
        return Calendar.current.date(byAdding: .day, value: -8, to: noon) ?? Date()
    }
    public var older: Date {
        return Calendar.current.date(byAdding: .day, value: -20, to: noon) ?? Date()
    }
    public var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon) ?? Date()
    }
    public var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon) ?? Date()
    }
    public var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self) ?? Date()
    }
    
    public func isToday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    public func isYesterday() -> Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    public func isWithinLast7Days() -> Bool {
        return (Date().lastWeek ... Date()).contains(self)
    }
}

let MaxTimestampAsDouble = Double(UInt64.max)

/** This is just like decimalSecondsStringToTimestamp, but it looks for values that seem to be
 *  milliseconds and fixes them. That's necessary because Firefox for iOS <= 7.3 uploaded millis
 *  when seconds were expected.
 */
public func someKindOfTimestampStringToTimestamp(_ input: String) -> Timestamp? {
    var double = 0.0
    if Scanner(string: input).scanDouble(&double) {
        // This should never happen. Hah!
        if double.isNaN || double.isInfinite {
            return nil
        }

        // `double` will be either huge or negatively huge on overflow, and 0 on underflow.
        // We clamp to reasonable ranges.
        if double < 0 {
            return nil
        }

        if double >= MaxTimestampAsDouble {
            // Definitely not representable as a timestamp if the seconds are this large!
            return nil
        }

        if double > 1000000000000 {
            // Oh, this was in milliseconds.
            return Timestamp(double)
        }

        let millis = double * 1000
        if millis >= MaxTimestampAsDouble {
            // Not representable as a timestamp.
            return nil
        }

        return Timestamp(millis)
    }
    return nil
}

public func decimalSecondsStringToTimestamp(_ input: String) -> Timestamp? {
    var double = 0.0
    if Scanner(string: input).scanDouble(&double) {
        // This should never happen. Hah!
        if double.isNaN || double.isInfinite {
            return nil
        }

        // `double` will be either huge or negatively huge on overflow, and 0 on underflow.
        // We clamp to reasonable ranges.
        if double < 0 {
            return nil
        }

        let millis = double * 1000
        if millis >= MaxTimestampAsDouble {
            // Not representable as a timestamp.
            return nil
        }

        return Timestamp(millis)
    }
    return nil
}

public func millisecondsToDecimalSeconds(_ input: Timestamp) -> String {
    let val = Double(input) / 1000
    return String(format: "%.2F", val)
}

public func millisecondsToSeconds(_ input: Timestamp) -> UInt64 {
    let val = input / 1000
    return val
}