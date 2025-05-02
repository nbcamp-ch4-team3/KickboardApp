//
//  Kickboard.swift
//  KickboardApp
//
//  Created by 이수현 on 4/25/25.
//

import Foundation

struct Kickboard: Codable {
    let id: UUID
    var latitude: Double
    var longitude: Double
    var battery: Int
    var isAvailable: Bool
    let date: Date
    let brand: Brand

    //TODO: 위, 경도 변경 / 배터리 닳기 / 사용여부 변경

    // 킥보드 등록 페이지에서 사용
    init(
        id: UUID,
        latitude: Double,
        longitude: Double,
        battery: Int,
        isAvailable: Bool,
        date: Date,
        brand: Brand
    ) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.battery = battery
        self.isAvailable = isAvailable
        self.brand = brand
        self.date = date
    }
}
