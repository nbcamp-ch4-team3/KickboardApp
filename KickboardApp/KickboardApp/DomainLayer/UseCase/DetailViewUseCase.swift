//
//  DetailViewUseCase.swift
//  KickboardApp
//
//  Created by 최안용 on 5/1/25.
//

import Foundation

protocol DetailViewUseCaseProtocol {
    func getHistory() throws -> [RideHistory]
    func getUseInfo() throws -> [UseInfo]
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
    
    func getUseInfo() throws -> [UseInfo] {
        return [.init(type: "뭐시기", date: "25.03.02", address: "경기도 수원시 팔달구", model: "1233A")]
//        return []
    }
}
