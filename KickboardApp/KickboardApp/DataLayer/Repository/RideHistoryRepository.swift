//
//  RideHistoryRepository.swift
//  KickboardApp
//
//  Created by 송규섭 on 5/1/25.
//

import Foundation

final class RideHistoryRepository: RideHistoryRepositoryProtocol {
    private let kickboardCoreData: KickboardCoreDataProtocol
    private let rideHistoryCoreData: RideHistoryCoreDataProtocol
    private let userCoreData: UserCoreDataProtocol

    init(
        kickboardCoreData: KickboardCoreDataProtocol,
        rideHistoryCoreData: RideHistoryCoreDataProtocol,
        userCoreData: UserCoreDataProtocol
    ) {
        self.kickboardCoreData = kickboardCoreData
        self.rideHistoryCoreData = rideHistoryCoreData
        self.userCoreData = userCoreData
    }

    func saveRideHistory(with rideHistory: RideHistory) throws {
        guard let userEntity = try userCoreData.findUser() else {
            throw CoreDataError.notFound("User")
        }

        guard let kickboardEntity = try kickboardCoreData.findKickboard(with: rideHistory.kickboard.id) else {
            throw CoreDataError.notFound("Kickboard")
        }

        try rideHistoryCoreData.saveData(
            user: userEntity,
            kickboard: kickboardEntity,
            with: rideHistory
        )
    }

    func getRideHistory() throws -> [RideHistory] {
        guard let userEntity = try userCoreData.findUser() else {
            throw CoreDataError.notFound("User")
        }

        let historyEntity = try rideHistoryCoreData.getHistory(user: userEntity)

        return historyEntity.compactMap { entity -> RideHistory? in
            guard let kickboardEntity = entity.kickboard,
                  let startTime = entity.startTime,
                  let endTime = entity.endTime
            else {
                return nil
            }

            guard let kickboardId = kickboardEntity.id,
                  let date = kickboardEntity.date,
                  let brandEntity = kickboardEntity.brand,
                  let brandTitle = brandEntity.title,
                  let brandImageName = brandEntity.imageName
            else {
                return nil
            }

            let brand = Brand(
                title: brandTitle,
                imageName: brandImageName,
                distancePerBatteryUnit: brandEntity.distancePerBatteryUnit,
                pricePerMinute: Int(brandEntity.pricePerMinute)
            )

            let kickboard = Kickboard(
                id: kickboardId,
                latitude: kickboardEntity.latitude,
                longitude: kickboardEntity.longitude,
                battery: Int(kickboardEntity.battery),
                isAvailable: kickboardEntity.isAvailable,
                date: date,
                brand: brand
            )

            return RideHistory(
                kickboard: kickboard,
                startTime: startTime,
                endTime: endTime,
                price: Int(entity.price)
            )
        }
    }
}
