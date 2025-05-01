//
//  HomeUseCase.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/30/25.
//

import Foundation

protocol HomeUseCaseProtocol {
    func getAllKickboard() throws -> [Kickboard]
}

final class HomeUseCase: HomeUseCaseProtocol {
    private let kickboardRepository: KickboardRepositoryProtocol

    init(
        kickboardRepository: KickboardRepositoryProtocol
    ) {
        self.kickboardRepository = kickboardRepository
    }

    func getAllKickboard() throws -> [Kickboard] {
        try kickboardRepository.getAllKickboard()
    }
}
