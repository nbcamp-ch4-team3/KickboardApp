//
//  LogInValidateUseCase.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/29/25.
//

import Foundation

class LogInValidateUseCase: LogInValidateUseCaseProtocol {
    private let userCoreData: UserCoreDataProtocol
    
    init(userCoreData: UserCoreDataProtocol) {
        self.userCoreData = userCoreData
    }
    
    // 코어 데이터에 해당 id가 있는지 확인
    func validateId(_ id: String) throws -> Bool {
        try userCoreData.isExistUser(id)
    }
    
    // 해당 id에 대해 비밀번호가 맞는지 확인
    func validatePassword(_ password: String, for id: String) throws -> Bool {
        try userCoreData.validatePassword(password, for: id)
    }
}
