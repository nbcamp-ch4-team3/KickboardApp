//
//  Kickboard.swift
//  KickboardApp
//
//  Created by 이수현 on 4/25/25.
//

import Foundation

struct Kickboard {
    let id: UUID
    var latitude: Double
    var longitude: Double
    var battery: Int
    var isAvailable: Bool
    let type: KickboardType

    //TODO: 위, 경도 변경 / 배터리 닳기 / 사용여부 변경

    // 킥보드 등록 페이지에서 사용
    init(
        id: UUID,
        latitude: Double,
        longitude: Double,
        battery: Int,
        isAvailable: Bool,
        type: KickboardType
    ) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.battery = battery
        self.isAvailable = isAvailable
        self.type = type
    }

    // CoreData Entity를 Model로 바꿀 때 사용 (CoreData는 type의 rawValue로 저장됨)
    init(
        id: UUID,
        latitude: Double,
        longitude: Double,
        battery: Int,
        isAvailable: Bool,
        typeString: String
    ) {
        let type = KickboardType.allCases.first(where: { $0.rawValue == typeString }) ?? .typeA
        self.init(
            id: id,
            latitude: latitude,
            longitude: longitude,
            battery: battery,
            isAvailable: isAvailable,
            type: type
        )
    }

}

enum KickboardType: String, CaseIterable {
    case typeA // 임시
    case typeB

    // 배터리당 갈 수 있는 거리 (주행 가능 거리 계산용)
    var distancePerBatteryUnit: Double {
        switch self {
        case .typeA:
            12
        case .typeB:
            10
        }
    }

    // 분당 가격
    var pricePerMinute: Int {
        switch  self {
        case .typeA:
            100
        case .typeB:
            200
        }
    }
}
