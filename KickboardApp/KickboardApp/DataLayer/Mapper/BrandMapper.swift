//
//  BrandMapper.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/30/25.
//

import Foundation

struct BrandMapper {
    static func toModel(from entity: BrandEntity) -> Brand {
        return Brand(
            title: entity.title ?? "브랜드",
            imageName: entity.imageName ?? "logo",
            distancePerBatteryUnit: entity.distancePerBatteryUnit,
            pricePerMinute: Int(entity.pricePerMinute)
        )
    }
}
