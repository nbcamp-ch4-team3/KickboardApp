//
//  SignUpView.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/29/25.
//

import UIKit
import SnapKit
import Then

final class SignUpView: UIView {
    let button = OnboardingButton(type: .confirm)
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let textField = OnboardingTextField(type: .signUpId)
    let confirmTextField = OnboardingTextField(type: .signUpConfirmPassword)
    
    private let appLogoImageView = UIImageView()
    private let textFieldStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    @available(*, unavailable, message: "compile error")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with status: SignUpStatus) {
        titleLabel.text = status.title
        descriptionLabel.text = status.description
        
        switch status {
        case .id:
            textField.configure(type: .signUpId)
        case .password:
            textField.configure(type: .signUpPassword)
            confirmTextField.isHidden = false
            confirmTextField.configure(type: .signUpConfirmPassword)
        case .nickname:
            button.configure(type: .signUp)
            textField.configure(type: .nickname)
        }
    }
}

extension SignUpView {
    func configure() {
        setHierarchy()
        setStyle()
        setConstraints()
    }
    
    func setHierarchy() {
        addSubViews(
            titleLabel,
            appLogoImageView,
            descriptionLabel,
            textFieldStackView,
            button
        )
        
        textFieldStackView.addArrangedSubviews(textField, confirmTextField)
    }
    
    func setStyle() {
        backgroundColor = .white
        
        titleLabel.do {
            $0.text = "아이디를 입력해주세요."
            $0.font = .font(.pretendardBold, ofSize: 20)
        }
        
        appLogoImageView.do {
            $0.image = UIImage(named: "logo4")
            $0.contentMode = .scaleAspectFit
        }
        
        descriptionLabel.do {
            $0.text = "아이디는 영문 소문자로 시작하는 5~20자\n길이의 영문 소문자, 숫자 조합이어야 합니다."
            $0.font = .font(.pretendardRegular, ofSize: 12)
            $0.numberOfLines = 0
        }
        
        textFieldStackView.do {
            $0.axis = .vertical
            $0.spacing = 20
        }
        
        confirmTextField.isHidden = true
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.leading.equalToSuperview().offset(50)
        }
        
        appLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(95)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(-15)
            $0.width.height.equalTo(50)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(50)
            $0.width.equalTo(300)
        }
        
        textField.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(48)
        }
        
        confirmTextField.snp.makeConstraints {
            $0.width.equalTo(300)
            $0.height.equalTo(48)
        }
        
        textFieldStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(textFieldStackView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(48)
        }
    }
}
