//
//  OnboardingButton.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/29/25.
//

import UIKit

final class OnboardingButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .primary
        clipsToBounds = true
        layer.cornerRadius = 24 // 버튼 높이 48
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .font(.pretendardBold, ofSize: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
