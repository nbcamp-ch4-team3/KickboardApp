//
//  SignUpViewModel.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/30/25.
//

import Foundation

final class SignUpViewModel {
    var id: String?
    var password: String?
    var nickname: String?
    
//    var status: SignUpStatus = .id
//    
//    func next() {
//        switch status {
//        case .id:
//            status = .password
//        case .password:
//            status = .nickname
//        case .nickname:
//            break
//        }
//    }
    
    private let signUpUseCase: SignUpUseCaseProtocol
    
    init(signUpUseCase: SignUpUseCaseProtocol) {
        self.signUpUseCase = signUpUseCase
    }
    
    // 아이디 검증
    func validateId(_ id: String) -> ValidateResult {
        print("id: \(id)")
        
        if id.count < 5 || id.count > 20 {
            return .invalid(message: "아이디는 5~20자입니다.")
        }
        
        guard let first = id.first, first.isLowercase else {
            return .invalid(message: "아이디는 영문 소문자로 시작해야 합니다.")
        }
        
        for char in id {
            if !char.isLowercase && !char.isNumber {
                return .invalid(message: "아이디는 영문 소문자, 숫자 조합입니다.")
            }
        }
        
        // 코어 데이터 중복 여부 확인
        do {
            let result = try signUpUseCase.isExistUser(id)
            if result {
                return .invalid(message: "이미 존재하는 아이디입니다.")
            }
        } catch {
            print(error)
        }
        
        self.id = id
        return .valid
    }
    
    // 비밀번호 검증
    func validatePassword(_ password: String, _ confirmPassword: String) -> ValidateResult {
        print("password: \(password)")
        
        guard password == confirmPassword else {
            return .invalid(message: "입력한 비밀번호가 일치하지 않습니다.")
        }
        
        if password.count < 8 || password.count > 20 {
            return .invalid(message: "비밀번호는 8~20자입니다.")
        }
        
        var hasLowercase = false
        var hasUppercase = false
        var hasDigit = false
        var hasSpecialChar = false
        
        for char in password {
            if char.isLowercase {
                hasLowercase = true
            } else if char.isUppercase {
                hasUppercase = true
            } else if char.isNumber {
                hasDigit = true
            } else if "!@#$%^&*()-_=+[{]}|;:'\",<.>/?`~".contains(char) {
                hasSpecialChar = true
            }
        }
        
        let typesCount = [hasLowercase, hasUppercase, hasDigit, hasSpecialChar].filter { $0 }.count
        if typesCount < 2 {
            return .invalid(message: "비밀번호는 영문 대/소문자, 숫자, 특수문자 중 2가지 이상을 조합해야 합니다.")
        }
        
        self.password = password
        return .valid
    }
    
    // 닉네임 검증
    func validateNickname(_ nickname: String) -> ValidateResult {
        if nickname.count < 2 || nickname.count > 10 {
            return .invalid(message: "닉네임은 2~10자입니다.")
        }
        
        for char in nickname {
            if !(char.isLetter || char.isNumber || isKorean(char)) {
                return .invalid(message: "닉네임은 한글, 영문, 숫자만 가능합니다.")
            }
        }
        
        self.nickname = nickname
        return .valid
    }
    
    // 닉네임에서 한글 여부 확인
    private func isKorean(_ char: Character) -> Bool {
        for scalar in char.unicodeScalars {
            if scalar.value >= 0xAC00 && scalar.value <= 0xD7A3 {
                return true
            }
        }
        return false
    }
    
    // 회원정보 저장
    func saveUserInfo() -> ValidateResult {
        guard let id, let password, let nickname else {
            return .invalid(message: "알 수 없는 오류가 발생했습니다.")
        }
        
        print("id: \(id), password: \(password), nickname: \(nickname)")
        
        // 코어 데이터에 회원정보 저장
        let user = User(id: id, password: password, nickname: nickname)
        do {
            try signUpUseCase.saveUserInfo(user)
        } catch {
            print(error)
        }
        
        return .valid
    }
}
