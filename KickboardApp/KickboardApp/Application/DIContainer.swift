//
//  DIContainer.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import CoreData
import UIKit

struct DIContainer {
    private let brandRepository: BrandRepositoryProtocol
    private let kickboardRepository: KickboardRepositoryProtocol
    private let userRepository: UserRepositoryProtocol

    init() {
        brandRepository = BrandRepository(coreData: BrandCoreData())
        kickboardRepository = KickboardRepository(coreData: KickboardCoreData())
        userRepository = UserRepository(coreData: UserCoreData())
    }

    func makeRegisterViewController() -> RegisterViewController {
        let useCase = RegisterUseCase(
            brandRepository: brandRepository,
            kickboardRepository: kickboardRepository,
            userRepository: userRepository
        )
        let viewModel = RegisterViewModel(useCase: useCase)
        return RegisterViewController(viewModel: viewModel)
    }
}
