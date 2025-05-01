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
            let kickboards: [Kickboard] = try kickboardEntities.compactMap {
                guard let brand = $0.brand else { throw CoreDataError.notFound("Brand") }
                let kickboard = Kickboard(
                    id: $0.id ?? UUID(),
                    latitude: $0.latitude,
                    longitude: $0.longitude,
                    battery: Int($0.battery),
                    isAvailable: $0.isAvailable,
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
}

