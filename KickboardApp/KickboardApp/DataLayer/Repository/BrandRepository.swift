//
//  BrandRepository.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import Foundation

final class BrandRepository: BrandRepositoryProtocol {

    private let coreData: BrandCoreDataProtocol

    init(coreData: BrandCoreData) {
        self.coreData = coreData
    }

    func getAllBrand() throws -> [Brand] {
        let result = try coreData.readAllData()
        return result.compactMap { entity -> Brand? in
            guard let title = entity.title,
                  let imageName = entity.imageName
            else {
                return nil
            }

            return Brand(
                title: title,
                imageName: imageName,
                distancePerBatteryUnit: entity.distancePerBatteryUnit,
                pricePerMinute: Int(entity.pricePerMinute)
            )
        }
    }
}
