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
}

final class HomeUseCase: HomeUseCaseProtocol {
    private let kickboardRepository: KickboardRepositoryProtocol
    private let localRepository: LocalRepositoryProtocol

    init(
        kickboardRepository: KickboardRepositoryProtocol,
        localRepository: LocalRepositoryProtocol
    ) {
        self.kickboardRepository = kickboardRepository
        self.localRepository = localRepository
    }

    func getAllKickboard() throws -> [Kickboard] {
        try kickboardRepository.getAllKickboard()
    }

    func fetchSearchResult(query: String) async throws -> [Local] {
        try await localRepository.fetchSearchResult(query: query)
    }
}
