//
//  DateUtility.swift
//  KickboardApp
//
//  Created by 송규섭 on 5/1/25.
//

import Foundation

class DateUtility {
    static let shared = DateUtility()

    init() {}

    func toHourAndMinuteString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    func minutesBetween(start: Date, end: Date) -> Int {
        let interval = end.timeIntervalSince(start)
        return Int(interval / 60)
    }
}
