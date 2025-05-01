//
//  RegisterViewModel.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import CoreLocation
import UIKit

protocol ViewModelProtocol {
    associatedtype Action
    var action: ((Action) -> Void)? { get }
}

protocol RegisterViewModelDelegate: AnyObject {
    func didUpdateBrands(_ brands: [Brand])
    func didSaveKickboard()
    func didFailWithError(_ error: AppError)

    func didUpdateLocation(_ location: CLLocation)
    func didRequestLocationServiceAlert(_ alert: UIAlertController)
}

final class RegisterViewModel: ViewModelProtocol {

    enum Action {
        case getAllBrand
        case saveKickboard(Kickboard)
        case getCurrentLocation
    }

    private let registerUseCase: RegisterUseCaseProtocol
    private let locationManagerUseCase: LocationManagerUseCaseProtocol

    weak var delegate: RegisterViewModelDelegate?

    var action: ((Action) -> Void)?

    init(
        registerUseCase: RegisterUseCaseProtocol,
        locationManagerUseCase: LocationManagerUseCaseProtocol
    ) {
        self.registerUseCase = registerUseCase
        self.locationManagerUseCase = locationManagerUseCase

        locationManagerUseCase.addDelegate(self)

        action = {[weak self] action in
            switch action {
            case .getAllBrand:
                self?.getAllBrand()
            case .saveKickboard(let kickboard):
                self?.saveKickboard(with: kickboard)
            case .getCurrentLocation:
                self?.getCurrentLocation()
            }
        }
    }

    private func getAllBrand() {
        do {
            let result = try registerUseCase.getAllBrand()
            delegate?.didUpdateBrands(result)
        } catch {
            delegate?.didFailWithError(AppError(error))
        }
    }

    private func saveKickboard(with kickboard: Kickboard) {
        do {
            _ = try registerUseCase.saveKickboard(with: kickboard)
            delegate?.didSaveKickboard()
        } catch {
            delegate?.didFailWithError(AppError(error))
        }
    }

    private func getCurrentLocation() {
        guard let location = locationManagerUseCase.getCurrentLocation() else { return }
        delegate?.didUpdateLocation(location)
    }
}

extension RegisterViewModel: LocationManagerRepositoryDelegate {
    func didUpdateLocation(_ location: CLLocation) {
        return
    }

    func showRequestLocationServiceAlert(_ alertController: UIAlertController) {
        delegate?.didRequestLocationServiceAlert(alertController)
    }
}
