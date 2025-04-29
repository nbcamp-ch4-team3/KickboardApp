//
//  OnboardingTextField.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/29/25.
//

import UIKit

class OnboardingTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        layer.cornerRadius = 24 // 텍스트 필드 높이 48
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0)) // 왼쪽 공백 추가
        leftViewMode = .always
        font = .font(.pretendardRegular, ofSize: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
