//
//  RegisterUseCase.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import Foundation

protocol RegisterUseCaseProtocol {
    func getAllBrand() throws -> [Brand]
}

final class RegisterUseCase: RegisterUseCaseProtocol {
    private let repository: BrandRepositoryProtocol

    init(repository: BrandRepositoryProtocol) {
        self.repository = repository
    }

    func getAllBrand() throws -> [Brand] {
        try repository.getAllBrand()
    }
}
