//
//  RideHistoryCoreData.swift
//  KickboardApp
//
//  Created by 송규섭 on 5/1/25.
//

import CoreData

protocol RideHistoryCoreDataProtocol {
    func saveData(user: UserEntity, kickboard: KickboardEntity, with rideHistory: RideHistory) throws
    func getHistory(user: UserEntity) throws -> [RideHistoryEntity]
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
        object.kickboard = kickboard

        do {
            try viewContext.save()
        } catch {
            throw CoreDataError.saveError(error)
        }
    }

    func getHistory(user: UserEntity) throws -> [RideHistoryEntity] {
        allHistory()
        let fetchRequst = RideHistoryEntity.fetchRequest()
        fetchRequst.predicate = NSPredicate(format: "user == %@", user.objectID)

        do {
            return try viewContext.fetch(fetchRequst)
        } catch {
            throw CoreDataError.readError(error)
        }
    }

    func allHistory() {
        do {
            let result = try viewContext.fetch(RideHistoryEntity.fetchRequest())
            print(result)
        } catch {
            print(error)
        }
    }
}
