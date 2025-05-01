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
}
