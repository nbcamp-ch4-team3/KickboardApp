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
        let brandCoreData = BrandCoreData()
        let kickboardCoreData = KickboardCoreData()
        let userCoreData = UserCoreData()

        brandRepository = BrandRepository(coreData:brandCoreData)
        kickboardRepository = KickboardRepository(
            kickboardCoreData: kickboardCoreData,
            userCoreData: userCoreData,
            brandCoreData: brandCoreData
        )
        userRepository = UserRepository(coreData:userCoreData)
    }

    func makeRegisterViewController() -> RegisterViewController {
        let useCase = RegisterUseCase(
            brandRepository: brandRepository,
            kickboardRepository: kickboardRepository
        )
        let viewModel = RegisterViewModel(useCase: useCase)
        return RegisterViewController(viewModel: viewModel)
    }
    
    func makeLogInViewController() -> LogInViewController {
        let useCase = LogInValidateUseCase(userRepository: userRepository)
        let viewModel = LogInViewModel(logInValidateUseCase: useCase)
        return LogInViewController(viewModel: viewModel)
    }
    
    func makeSignUpViewController() -> SignUpViewController {
        let useCase = SignUpUseCase(userRepository: userRepository)
        let viewModel = SignUpViewModel(signUpUseCase: useCase)
        return SignUpViewController(status: .id, viewModel: viewModel)
    }
}
