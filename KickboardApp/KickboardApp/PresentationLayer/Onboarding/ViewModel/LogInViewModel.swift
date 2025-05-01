//
//  LogInViewModel.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/29/25.
//

import Foundation

enum ValidateResult: Comparable {
    case valid
    case invalid(message: String)
}

final class LogInViewModel {
    private let logInValidateUseCase: LogInValidateUseCaseProtocol
    
    init(logInValidateUseCase: LogInValidateUseCaseProtocol) {
        self.logInValidateUseCase = logInValidateUseCase
    }
    
    func validate(id: String, password: String) -> ValidateResult {
        guard validateId(id) else {
            return .invalid(message: "ID가 유효하지 않습니다.")
        }
        
        guard validatePassword(password, for: id) else {
            return .invalid(message: "비밀번호가 유효하지 않습니다.")
        }
        
        LogInManager.shared.saveLogInInfo(id) // 자동 로그인 아이디 저장
        return .valid
    }
    
    // 코어 데이터에 해당 id가 있는지 확인
    private func validateId(_ id: String) -> Bool {
        do {
            return try logInValidateUseCase.validateId(id)
        } catch {
            print("validateId error: \(error)")
            return false
        }
    }
    
    // 해당 id에 대해 비밀번호가 맞는지 확인
    private func validatePassword(_ password: String, for id: String) -> Bool {
        do {
            return try logInValidateUseCase.validatePassword(password, for: id)
        } catch {
            print("validatePassword error: \(error)")
            return false
        }
    }
}
