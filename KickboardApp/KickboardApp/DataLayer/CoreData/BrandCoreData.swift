//
//  BrandCoreData.swift
//  KickboardApp
//
//  Created by 이수현 on 4/28/25.
//

import CoreData

protocol BrandCoreDataProtocol {
    func readAllData() throws -> [BrandEntity]
    func findBrand(with title: String) throws -> BrandEntity?
}

final class BrandCoreData: BrandCoreDataProtocol {
    private let viewContext: NSManagedObjectContext

    init() {
        self.viewContext = CoreDataStorage.shared.persistentContainer.viewContext
    }

    func findBrand(with title: String) throws -> BrandEntity? {
        let fetchRequest = BrandEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        return try viewContext.fetch(fetchRequest).first
    }

    func readAllData() throws -> [BrandEntity] {
        do {
            return try viewContext.fetch(BrandEntity.fetchRequest())
        } catch {
            throw CoreDataError.readError(error)
        }
    }
}

extension BrandCoreData {
    private func saveMockData() {
        Brand.mockData()
            .forEach {
                let brandEntity = BrandEntity(context: viewContext)
                brandEntity.title = $0.title
                brandEntity.imageName = $0.imageName
                brandEntity.distancePerBatteryUnit = $0.distancePerBatteryUnit
                brandEntity.pricePerMinute = Int64($0.pricePerMinute)
            }

        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func saveData(with data: Brand) {
        let object = BrandEntity(context: viewContext)
        object.title = data.title
        object.imageName = data.imageName
        object.pricePerMinute = Int64(data.pricePerMinute)
        object.distancePerBatteryUnit = data.distancePerBatteryUnit

        do {
            try viewContext.save()
        } catch {
            print(CoreDataError.saveError(error))
        }
    }

    private func deleteAllData() {
        do {
            let reult = try viewContext.fetch(BrandEntity.fetchRequest())
            reult.forEach {
                viewContext.delete($0)
            }

            try viewContext.save()
        } catch {
            print(CoreDataError.deleteError(error))
        }
    }
}
