//
//  OnboardingButton.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/29/25.
//

import UIKit

enum OnboardingButtonType {
    case logIn
    case confirm
    case signUp
    
    var title: String {
        switch self {
        case .logIn:
            "로그인"
        case .confirm:
            "확인"
        case .signUp:
            "회원가입"
        }
    }
}

final class OnboardingButton: UIButton {
    var type: OnboardingButtonType
    
    init(type: OnboardingButtonType) {
        self.type = type
        super.init(frame: .zero)
        
        backgroundColor = .primary
        clipsToBounds = true
        layer.cornerRadius = 24 // 버튼 높이 48
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .font(.pretendardBold, ofSize: 18)
        setTitle(type.title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(type: OnboardingButtonType) {
        setTitle(type.title, for: .normal)
    }
}
