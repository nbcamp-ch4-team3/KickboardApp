//
//  DetailViewUseCase.swift
//  KickboardApp
//
//  Created by 최안용 on 5/1/25.
//

import Foundation

protocol DetailViewUseCaseProtocol {
    func getHistory() throws -> [History]
    func getUseInfo() throws -> [UseInfo]
    func deleteHistory(id: Int) throws
    func deleteUseInfo(id: Int) throws
}

final class DetailViewUseCase: DetailViewUseCaseProtocol {
    private let kickboardRepository: KickboardRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    
    init(
        kickboardRepository: KickboardRepositoryProtocol,
        userRepository: UserRepositoryProtocol
    ) {
        self.kickboardRepository = kickboardRepository
        self.userRepository = userRepository
    }
    
    func getHistory() throws -> [History] {
        return [.init(type: "뭐시기", date: "25.03.02", time: "13:32 ~ 15:11", amount: "31,230원", model: "1233A")]
    }
    
    func getUseInfo() throws -> [UseInfo] {
        return [.init(type: "뭐시기", date: "25.03.02", address: "경기도 수원시 팔달구", model: "1233A")]
    }
    
    func deleteHistory(id: Int) throws {
        
    }
    
    func deleteUseInfo(id: Int) throws {
        
    }
}
