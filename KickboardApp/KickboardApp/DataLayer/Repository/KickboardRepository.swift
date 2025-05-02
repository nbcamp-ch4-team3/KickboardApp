//
//  KickboardRepository.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import Foundation

final class KickboardRepository: KickboardRepositoryProtocol {

    private let kickboardCoreData: KickboardCoreDataProtocol
    private let userCoreData: UserCoreDataProtocol
    private let brandCoreData: BrandCoreDataProtocol

    init(
        kickboardCoreData: KickboardCoreDataProtocol,
        userCoreData: UserCoreDataProtocol,
        brandCoreData: BrandCoreDataProtocol
    ) {
        self.kickboardCoreData = kickboardCoreData
        self.userCoreData = userCoreData
        self.brandCoreData = brandCoreData
    }

    func saveKickboard(with kickboard: Kickboard) throws {
        guard let userEntity = try userCoreData.findUser() else {
            throw CoreDataError.notFound("User")
        }

        guard let brandEntity = try brandCoreData.findBrand(with: kickboard.brand.title) else {
            throw CoreDataError.notFound("Brand")
        }

        try kickboardCoreData.saveData(
            user: userEntity,
            brand: brandEntity,
            with: kickboard
        )
    }

    func getAllKickboard() throws -> [Kickboard] {
        do {
            let kickboardEntities = try kickboardCoreData.readAllData()
            let kickboards: [Kickboard] = try kickboardEntities.compactMap { entity -> Kickboard? in
                guard let brand = entity.brand else { throw CoreDataError.notFound("Brand") }
                guard let id = entity.id,
                      let date = entity.date
                else {
                    return nil
                }
                let kickboard = Kickboard(
                    id: id,
                    latitude: entity.latitude,
                    longitude: entity.longitude,
                    battery: Int(entity.battery),
                    isAvailable: entity.isAvailable,
                    date: date,
                    brand: BrandMapper.toModel(from: brand)
                )
                return kickboard
            }
            return kickboards
        } catch {
            throw CoreDataError.readError(error)
        }
    }

    func updateLocation(id: UUID, latitude: Double, longitude: Double) throws {
        do {
            try kickboardCoreData.updateLocation(id: id, latitude: latitude, longitude: longitude)
        } catch {
            throw CoreDataError.updateError(error)
        }
    }

    func getRegisteredKickboards() throws -> [Kickboard] {
        guard let userEntity = try userCoreData.findUser() else {
            throw CoreDataError.notFound("User")
        }

        let kickboardEntities = try kickboardCoreData.readResgisteredData(user: userEntity)
        return kickboardEntities.compactMap { entity -> Kickboard? in
            guard let id = entity.id,
                  let brandEntity = entity.brand,
                  let brandTitle = brandEntity.title,
                  let imageName = brandEntity.imageName,
                  let date = entity.date
            else {
                return nil
            }

            let brand = Brand(
                title: brandTitle,
                imageName: imageName,
                distancePerBatteryUnit: brandEntity.distancePerBatteryUnit,
                pricePerMinute: Int(brandEntity.pricePerMinute)
            )

            return Kickboard(
                id: id,
                latitude: entity.latitude,
                longitude: entity.longitude,
                battery: Int(entity.battery),
                isAvailable: entity.isAvailable,
                date: date,
                brand: brand
            )
        }
    }
}

