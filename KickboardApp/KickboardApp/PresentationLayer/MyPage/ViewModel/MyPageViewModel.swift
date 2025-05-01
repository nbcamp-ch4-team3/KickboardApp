//
//  MyPageViewModel.swift
//  KickboardApp
//
//  Created by 최안용 on 5/1/25.
//

import Foundation

protocol MyPageViewModelDelegate: AnyObject {
    func didUpdateUser(_ userName: String)
    func didUpdateIsUsed(_ isUsed: Bool)
    func didFailWithError(_ error: AppError)
}

final class MyPageViewModel: ViewModelProtocol {
    enum Action {
        case getUserInfo
        case getIsUsed
    }
    
    private let useCase: MyPageUseCaseProtocol
    weak var delegate: MyPageViewModelDelegate?
    var action: ((Action) -> Void)?
    
    init(useCase: MyPageUseCaseProtocol) {
        self.useCase = useCase
        
        action = { [weak self] action in
            switch action {
            case .getUserInfo:
                self?.getUserInfo()
            case .getIsUsed:
                self?.getIsUsed()
            }
        }
    }
    
    private func getUserInfo() {
        do {
            let result = try useCase.getUserInfo()
            delegate?.didUpdateUser(result.nickname)
        } catch {
            delegate?.didFailWithError(AppError(error))
        }
    }
    
    private func getIsUsed() {
        do {
            let result = try useCase.getIsUsedkickboard()
            delegate?.didUpdateIsUsed(result)
        } catch {
            delegate?.didFailWithError(AppError(error))
        }
    }
}
