//
//  Brand.swift
//  KickboardApp
//
//  Created by 이수현 on 4/28/25.
//

import Foundation

struct Brand: Codable {
    let title: String
    let imageName: String
    let distancePerBatteryUnit: Double
    let pricePerMinute: Int
}

extension Brand {
    static func mockData() -> [Brand] {
        return [
            Brand(
                title: "킥",
                imageName: "kick",
                distancePerBatteryUnit: 0.5,
                pricePerMinute: 300
            ),
            Brand(
                title: "씽씽",
                imageName: "ssingSsing",
                distancePerBatteryUnit: 2.1,
                pricePerMinute: 600
            ),
            Brand(
                title: "빔",
                imageName: "beam",
                distancePerBatteryUnit: 1.2,
                pricePerMinute: 400
            ),
        ]
    }
}
