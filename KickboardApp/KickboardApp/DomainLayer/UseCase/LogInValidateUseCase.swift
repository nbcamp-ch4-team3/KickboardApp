//
//  LogInValidateUseCase.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/29/25.
//

import Foundation

protocol LogInValidateUseCaseProtocol {
    func validateId(_ id: String) throws -> Bool
    func validatePassword(_ password: String, for id: String) throws -> Bool
}

class LogInValidateUseCase: LogInValidateUseCaseProtocol {
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    // 코어 데이터에 해당 id가 있는지 확인
    func validateId(_ id: String) throws -> Bool {
        try userRepository.isExistUser(id)
    }
    
    // 해당 id에 대해 비밀번호가 맞는지 확인
    func validatePassword(_ password: String, for id: String) throws -> Bool {
        try userRepository.validatePassword(password, for: id)
    }
}
