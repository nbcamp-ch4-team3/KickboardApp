//
//  SignUpUseCase.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/30/25.
//

import Foundation

protocol SignUpUseCaseProtocol {
    func isExistUser(_ id: String) throws -> Bool
    func saveUserInfo(_ user: User) throws
}

class SignUpUseCase: SignUpUseCaseProtocol {
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    func isExistUser(_ id: String) throws -> Bool {
        try userRepository.isExistUser(id)
    }
    
    func saveUserInfo(_ user: User) throws {
        try userRepository.saveUserInfo(user)
    }
}
