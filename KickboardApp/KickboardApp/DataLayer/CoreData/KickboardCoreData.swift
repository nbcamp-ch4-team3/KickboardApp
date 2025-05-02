//
//  KickboardCoreData.swift
//  KickboardApp
//
//  Created by 이수현 on 4/25/25.
//

import CoreData

protocol KickboardCoreDataProtocol {
    func saveData(user: UserEntity, brand: BrandEntity, with data: Kickboard) throws
    func readAllData() throws -> [KickboardEntity]
    func updateLocation(id: UUID, latitude: Double, longitude: Double) throws
    func deleteAllData() throws
    func findKickboard(with id: UUID) throws -> KickboardEntity?
    func readResgisteredData(user: UserEntity) throws -> [KickboardEntity]
}

final class KickboardCoreData: KickboardCoreDataProtocol {

    private let viewContext: NSManagedObjectContext

    init() {
        self.viewContext = CoreDataStorage.shared.persistentContainer.viewContext
    }

    func saveData(user: UserEntity, brand: BrandEntity, with data: Kickboard) throws {
        let object = KickboardEntity(context: viewContext)
        object.id = data.id
        object.battery = Int64(data.battery)
        object.isAvailable = data.isAvailable
        object.latitude = data.latitude
        object.longitude = data.longitude
        object.date = data.date
        object.brand = brand
        object.user = user

        do {
            try viewContext.save()
        } catch {
            throw CoreDataError.saveError(error)
        }
    }

    //TODO: latitude, longitude, 지도의 범위를 받아서 필터링
    func readAllData() throws -> [KickboardEntity] {
        do {
            return try viewContext.fetch(KickboardEntity.fetchRequest())
        } catch {
            throw CoreDataError.readError(error)
        }
    }

    func updateLocation(id: UUID, latitude: Double, longitude: Double) throws {
        let fetchRequest = KickboardEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let result = try viewContext.fetch(fetchRequest)
            result.forEach {
                $0.latitude = latitude
                $0.longitude = longitude
            }
            try viewContext.save()
        } catch {
            throw CoreDataError.updateError(error)
        }
    }

    func findKickboard(with id: UUID) throws -> KickboardEntity? {
        let fetchRequest = KickboardEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        return try viewContext.fetch(fetchRequest).first
    }

    func readResgisteredData(user: UserEntity) throws -> [KickboardEntity] {
        let fetchRequest = KickboardEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "user == %@", user.objectID)

        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            throw CoreDataError.readError(error)
        }
    }
}

extension KickboardCoreData {
    func deleteAllData() throws {
        do {
            let result = try viewContext.fetch(KickboardEntity.fetchRequest())
            result.forEach { viewContext.delete($0) }
            try viewContext.save()
        } catch {
            throw CoreDataError.deleteError(error)
        }
    }
}
