//
//  DetailViewModel.swift
//  KickboardApp
//
//  Created by 최안용 on 5/1/25.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func getInfo()
    func deleteCell()
    func didFailWithError(_ error: AppError)
}

final class DetailViewModel: ViewModelProtocol {
    enum Action {
        case getInfo
        case deleteCell(index: Int)
    }
    
    private(set) var historys: [History] = []
    private(set) var useInfos: [UseInfo] = []
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
            case let .deleteCell(index):
                self?.deleteCell(index: index)
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
                let result = try useCase.getUseInfo()
                useInfos = result
                delegate?.getInfo()
            }
        } catch {
            delegate?.didFailWithError(AppError(error))
        }
    }
    
    private func deleteCell(index: Int) {
        do {
            switch pageType {
            case .history:
                try useCase.deleteHistory(id: 1)
                historys.remove(at: index)
            case .kickboard:
                try useCase.deleteUseInfo(id: 1)
                useInfos.remove(at: index)
            }
        } catch {
            delegate?.didFailWithError(AppError(error))
        }
    }
}
