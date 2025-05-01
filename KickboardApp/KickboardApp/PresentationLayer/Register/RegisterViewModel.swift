//
//  RegisterViewModel.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Action
    var action: ((Action) -> Void)? { get }
}

protocol RegisterViewModelDelegate: AnyObject {
    func didUpdateBrands(_ brands: [Brand])
    func didSaveKickboard()
    func didFailWithError(_ error: AppError)
}

final class RegisterViewModel: ViewModelProtocol {

    enum Action {
        case getAllBrand
        case saveKickboard(Kickboard)
    }

    private let useCase: RegisterUseCaseProtocol

    weak var delegate: RegisterViewModelDelegate?

    var action: ((Action) -> Void)?

    init(useCase: RegisterUseCaseProtocol) {
        self.useCase = useCase

        action = {[weak self] action in
            switch action {
            case .getAllBrand:
                self?.getAllBrand()
            case .saveKickboard(let kickboard):
                self?.saveKickboard(with: kickboard)
            }
        }
    }

    private func getAllBrand() {
        do {
            let result = try useCase.getAllBrand()
            delegate?.didUpdateBrands(result)
        } catch {
            delegate?.didFailWithError(AppError(error))
        }
    }

    private func saveKickboard(with kickboard: Kickboard) {
        do {
            _ = try useCase.saveKickboard(with: kickboard)
            delegate?.didSaveKickboard()
        } catch {
            delegate?.didFailWithError(AppError(error))
        }
    }
}
