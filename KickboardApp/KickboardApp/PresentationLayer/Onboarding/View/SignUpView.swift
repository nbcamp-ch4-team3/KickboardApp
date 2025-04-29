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
    let button = OnboardingButton()
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let textField = OnboardingTextField()
    let confirmTextField = OnboardingTextField()
    
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
            $0.font = .font(.pretendardRegular, ofSize: 14)
            $0.numberOfLines = 0
        }
        
        textField.do {
            $0.placeholder = "아이디"
        }
        
        confirmTextField.do {
            $0.placeholder = "비밀번호 확인"
        }
        
        textFieldStackView.do {
            $0.axis = .vertical
            $0.spacing = 20
        }
        
        button.do {
            $0.setTitle("확인", for: .normal)
        }
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
            $0.width.equalTo(250)
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
