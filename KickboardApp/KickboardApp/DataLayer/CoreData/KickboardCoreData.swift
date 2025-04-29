//
//  KickboardCoreData.swift
//  KickboardApp
//
//  Created by 이수현 on 4/25/25.
//

import CoreData

protocol KickboardCoreDataProtocol {
    func saveData(user: User, with data: Kickboard) throws
    func readAllData() throws -> [KickboardEntity]
    func updateLocation(id: UUID, latitude: Double, longitude: Double) throws
    func deleteAllData() throws
}

final class KickboardCoreData: KickboardCoreDataProtocol {
    private let viewContext: NSManagedObjectContext

    init() {
        self.viewContext = CoreDataStorage.shared.persistentContainer.viewContext
    }

    func saveData(user: User, with data: Kickboard) throws {
        let object = KickboardEntity(context: viewContext)
        object.id = data.id
        object.battery = Int64(data.battery)
        object.isAvailable = data.isAvailable
        object.latitude = data.latitude
        object.longitude = data.longitude

        let brandEntity = BrandEntity(context: viewContext)
        brandEntity.title = data.brand.title
        brandEntity.imageName = data.brand.imageName
        brandEntity.distancePerBatteryUnit = data.brand.distancePerBatteryUnit
        brandEntity.pricePerMinute = Int64(data.brand.pricePerMinute)
        object.brand = brandEntity

        let userEntity = UserEntity(context: viewContext)
        userEntity.id = user.id
        userEntity.nickname = user.nickname
        userEntity.password = user.password
        object.user = userEntity

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
