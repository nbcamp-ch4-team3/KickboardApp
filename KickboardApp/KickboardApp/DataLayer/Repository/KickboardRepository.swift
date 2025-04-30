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
}
