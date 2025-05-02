//
//  DetailViewModel.swift
//  KickboardApp
//
//  Created by 최안용 on 5/1/25.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func getInfo()
    func didFailWithError(_ error: AppError)
}

final class DetailViewModel: ViewModelProtocol {
    enum Action {
        case getInfo
    }
    
    private(set) var historys: [RideHistory] = []
    private(set) var registeredKickboards: [Kickboard] = []
    private(set) var pageType: PageType
    private let useCase: DetailViewUseCaseProtocol
    weak var delegate: DetailViewModelDelegate?
    var action: ((Action) -> Void)?
    
    init(
        pageType: PageType,
        useCase: DetailViewUseCaseProtocol
    ) {
        self.pageType = pageType
        self.useCase = useCase
        
        action = { [weak self] action in
            switch action {
            case .getInfo:
                self?.getInfo()
            }
        }
    }
    
    private func getInfo() {
        do {
            switch pageType {
            case .history:
                let result = try useCase.getHistory()
                historys = result
                delegate?.getInfo()
            case .kickboard:
                let result = try useCase.getRegisteredKickboards()
                registeredKickboards = result
                delegate?.getInfo()
            }
        } catch {
            delegate?.didFailWithError(AppError(error))
        }
    }
}
