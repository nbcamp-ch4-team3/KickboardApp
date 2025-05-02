//
//  DetailViewUseCase.swift
//  KickboardApp
//
//  Created by 최안용 on 5/1/25.
//

import Foundation

protocol DetailViewUseCaseProtocol {
    func getHistory() throws -> [RideHistory]
    func getRegisteredKickboards() throws -> [Kickboard]
}

final class DetailViewUseCase: DetailViewUseCaseProtocol {
    private let kickboardRepository: KickboardRepositoryProtocol
    private let historyRepository: RideHistoryRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private let addressManager = AddressManager()
    
    init(
        kickboardRepository: KickboardRepositoryProtocol,
        userRepository: UserRepositoryProtocol,
        historyRepository: RideHistoryRepositoryProtocol
    ) {
        self.kickboardRepository = kickboardRepository
        self.userRepository = userRepository
        self.historyRepository = historyRepository
    }
    
    func getHistory() throws -> [RideHistory] {
        return try historyRepository.getRideHistory()
    }
    
    func getRegisteredKickboards() throws -> [Kickboard] {
        return try kickboardRepository.getRegisteredKickboards()
    }
}
