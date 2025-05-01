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
    
    var isSecureTextEntry: Bool {
        switch self {
        case .logInPassword, .signUpPassword, .signUpConfirmPassword:
            true
        default:
            false
        }
    }
}

final class OnboardingTextField: UITextField {
    var type: OnboardingTextFieldType
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.sizeToFit()
        button.tintColor = .gray2
        return button
    }()
    
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
        autocorrectionType = .no
        autocapitalizationType = .none
        
        let containerWidth = button.frame.width + 20
        let containerHeight = max(button.frame.height, 40)
        let container = UIView(frame: CGRect(x: 0, y: 0, width: containerWidth, height: containerHeight))
        
        button.frame.origin = CGPoint(x: 0, y: (containerHeight - button.frame.height) / 2)
        container.addSubview(button)
        
        rightView = container
        rightViewMode = .always
        
        configure(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(type: OnboardingTextFieldType) {
        placeholder = type.placeholder
        isSecureTextEntry = type.isSecureTextEntry
        
//        if type == .signUpId || type == .nickname {
//            button.setTitle("인증", for: .normal)
//        }
        
        if type == .logInPassword || type == .signUpPassword || type == .signUpConfirmPassword {
            let image = UIImage(systemName: "eye.slash")
            button.setImage(image, for: .normal)
        }
    }
    
    func toggleSecureTextEntry() {
        isSecureTextEntry.toggle()
        if isSecureTextEntry {
            let image = UIImage(systemName: "eye.slash")
            button.setImage(image, for: .normal)
        } else {
            let image = UIImage(systemName: "eye")
            button.setImage(image, for: .normal)
        }
    }
}
