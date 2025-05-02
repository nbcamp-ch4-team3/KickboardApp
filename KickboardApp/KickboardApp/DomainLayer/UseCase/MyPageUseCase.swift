//
//  MyPageUseCase.swift
//  KickboardApp
//
//  Created by 최안용 on 5/1/25.
//

import Foundation

protocol MyPageUseCaseProtocol {
    func getUserInfo() throws -> User
    func getIsUsedkickboard() throws -> Bool
}

final class MyPageUseCase: MyPageUseCaseProtocol {
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    func getUserInfo() throws -> User {
        return try userRepository.readMyUserInfo()
    }
    
    func getIsUsedkickboard() throws -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsKey.isRiding.rawValue)
    }
}
