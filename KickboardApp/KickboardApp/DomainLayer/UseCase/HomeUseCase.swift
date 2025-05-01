//
//  HomeUseCase.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/30/25.
//

import Foundation

protocol HomeUseCaseProtocol {
    func getAllKickboard() throws -> [Kickboard]
    func fetchSearchResult(query: String) async throws -> [Local]
    func saveRideHistory(with rideHistory: RideHistory) throws -> Void
}

final class HomeUseCase: HomeUseCaseProtocol {
    private let kickboardRepository: KickboardRepositoryProtocol
    private let localRepository: LocalRepositoryProtocol
    private let rideHistoryRepository: RideHistoryRepositoryProtocol

    init(
        kickboardRepository: KickboardRepositoryProtocol,
        localRepository: LocalRepositoryProtocol,
        rideHistoryRepository: RideHistoryRepositoryProtocol
    ) {
        self.kickboardRepository = kickboardRepository
        self.localRepository = localRepository
        self.rideHistoryRepository = rideHistoryRepository
    }

    func getAllKickboard() throws -> [Kickboard] {
        try kickboardRepository.getAllKickboard()
    }

    func fetchSearchResult(query: String) async throws -> [Local] {
        try await localRepository.fetchSearchResult(query: query)
    }

    func saveRideHistory(with rideHistory: RideHistory) throws -> Void {
        try rideHistoryRepository.saveRideHistory(with: rideHistory)
    }
}
