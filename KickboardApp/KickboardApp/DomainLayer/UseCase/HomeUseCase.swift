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

    init(
        kickboardRepository: KickboardRepositoryProtocol
    ) {
        self.kickboardRepository = kickboardRepository
    }

    func getAllKickboard() throws -> [Kickboard] {
        try kickboardRepository.getAllKickboard()
    }
}

    func fetchLocalInfo(query: String) async throws -> [Local]
    private let localRepository: LocalRepositoryProtocol
    init(localRepository: LocalRepositoryProtocol) {

        self.localRepository = localRepository
    }
    func fetchLocalInfo(query: String) async throws -> [Local] {
        try await localRepository.fetchLocalInfo(query: query)

    func fetchSearchResult(query: String) async throws -> [Local] {
        try await localRepository.fetchSearchResult(query: query)
    }