//
//  RegisterUseCase.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import Foundation

protocol RegisterUseCaseProtocol {
    func getAllBrand() throws -> [Brand]
    func saveKickboard(with kickboard: Kickboard) throws -> Void
}

final class RegisterUseCase: RegisterUseCaseProtocol {
    private let brandRepository: BrandRepositoryProtocol
    private let kickboardRepository: KickboardRepositoryProtocol

    init(
        brandRepository: BrandRepositoryProtocol,
        kickboardRepository: KickboardRepositoryProtocol
    ) {
        self.brandRepository = brandRepository
        self.kickboardRepository = kickboardRepository
    }

    func getAllBrand() throws -> [Brand] {
        try brandRepository.getAllBrand()
    }

    func saveKickboard(with kickboard: Kickboard) throws -> Void {
        try kickboardRepository.saveKickboard(with: kickboard)
    }
}
