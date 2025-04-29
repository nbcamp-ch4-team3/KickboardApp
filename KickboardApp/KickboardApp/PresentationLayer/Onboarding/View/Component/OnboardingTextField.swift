//
//  OnboardingTextField.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/29/25.
//

import UIKit

enum OnboardingTextFieldType {
    case logInId
    case logInPassword
    case signUpId
    case signUpPassword
    case signUpConfirmPassword
    case nickname
    
    var placeholder: String {
        switch self {
        case .logInId, .signUpId:
            "아이디"
        case .logInPassword, .signUpPassword:
            "비밀번호"
        case .signUpConfirmPassword:
            "비밀번호 확인"
        case .nickname:
            "닉네임"
        }
    }
}

final class OnboardingTextField: UITextField {
    let type: OnboardingTextFieldType
    
    init(type: OnboardingTextFieldType) {
        self.type = type
        super.init(frame: .zero)
        
        clipsToBounds = true
        layer.cornerRadius = 24 // 텍스트 필드 높이 48
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0)) // 왼쪽 공백 추가
        leftViewMode = .always
        font = .font(.pretendardRegular, ofSize: 18)
        placeholder = type.placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
