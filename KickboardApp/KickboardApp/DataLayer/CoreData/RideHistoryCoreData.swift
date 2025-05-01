//
//  RideHistoryCoreData.swift
//  KickboardApp
//
//  Created by 송규섭 on 5/1/25.
//

import CoreData

protocol RideHistoryCoreDataProtocol {
    func saveData(user: UserEntity, kickboard: KickboardEntity, with rideHistory: RideHistory) throws
}

final class RideHistoryCoreData: RideHistoryCoreDataProtocol {
    private let viewContext: NSManagedObjectContext

    init() {
        self.viewContext = CoreDataStorage.shared.persistentContainer.viewContext
    }

    func saveData(user: UserEntity, kickboard: KickboardEntity, with rideHistory: RideHistory) throws {
        let object = RideHistoryEntity(context: viewContext)
        object.id = kickboard.id
        object.startTime = rideHistory.startTime
        object.endTime = rideHistory.endTime
        object.price = Int64(rideHistory.price)
        object.user = user

        do {
            try viewContext.save()
        } catch {
            throw CoreDataError.saveError(error)
        }
    }
}
