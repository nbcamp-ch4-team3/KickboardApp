//
//  DIContainer.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import CoreData
import UIKit
import CoreLocation

final class DIContainer {
    static let shared = DIContainer()
    
    private let brandRepository: BrandRepositoryProtocol
    private let kickboardRepository: KickboardRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private let localRepository: LocalRepositoryProtocol
    private let rideHistoryRepository: RideHistoryRepositoryProtocol
    private let locationManagerUseCase: LocationManagerUseCaseProtocol

    private init() {
        let brandCoreData = BrandCoreData()
        let kickboardCoreData = KickboardCoreData()
        let userCoreData = UserCoreData()
        let networkService = NetworkService()
        let locationManager = CLLocationManager()
        let locationManagerRepository = LocationManagerRepository(locationManager: locationManager)
        let rideHistoryCoreData = RideHistoryCoreData()

        brandRepository = BrandRepository(coreData:brandCoreData)
        kickboardRepository = KickboardRepository(
            kickboardCoreData: kickboardCoreData,
            userCoreData: userCoreData,
            brandCoreData: brandCoreData
        )
        userRepository = UserRepository(coreData:userCoreData)
        localRepository = LocalRepository(service: networkService)
        rideHistoryRepository = RideHistoryRepository(
            kickboardCoreData: kickboardCoreData,
            rideHistoryCoreData: rideHistoryCoreData,
            userCoreData: userCoreData
        )

        locationManagerUseCase = LocationManagerUseCase(locationManagerRepository: locationManagerRepository)
    }

    func makeHomeViewController() -> HomeViewController {
        let homeUseCase = HomeUseCase(
            kickboardRepository: kickboardRepository,
            localRepository: localRepository,
            rideHistoryRepository: rideHistoryRepository
        )
        let viewModel = HomeViewModel(
            homeUseCase: homeUseCase,
            locationManagerUseCase: locationManagerUseCase
        )
        return HomeViewController(viewModel: viewModel)
    }

    func makeRegisterViewController() -> RegisterViewController {
        let registerUseCase = RegisterUseCase(
            brandRepository: brandRepository,
            kickboardRepository: kickboardRepository
        )

        let viewModel = RegisterViewModel(
            registerUseCase: registerUseCase,
            locationManagerUseCase: locationManagerUseCase
        )

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
        return SignUpViewController(viewModel: viewModel)
    }
    
    func makeMyPageViewController() -> MyPageViewController {
        let useCase = MyPageUseCase(userRepository: userRepository)
        let viewModel = MyPageViewModel(useCase: useCase)
        return MyPageViewController(viewModel: viewModel)
    }
    
    func makeDetailUseCase() -> DetailViewUseCase {
        let useCase = DetailViewUseCase(
            kickboardRepository: kickboardRepository,
            userRepository: userRepository,
            historyRepository: rideHistoryRepository
        )
        return useCase
    }
}
