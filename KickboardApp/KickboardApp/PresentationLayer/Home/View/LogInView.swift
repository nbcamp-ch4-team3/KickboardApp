//
//  LogInView.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/28/25.
//

import UIKit
import SnapKit
import Then

final class LogInView: UIView {
    let logInButton = UIButton()
    let signUpButton = UIButton()
    
    private let idTextfield = UITextField()
    private let passwordTextField = UITextField()
    
    private let appLogoImageView = UIImageView()
    private let appNameImageView = UIImageView()
    
    private let signUpLabel = UILabel()
    private let signUpStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    @available(*, unavailable, message: "compile error")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LogInView {
    func configure() {
        setHierarchy()
        setStyle()
        setConstraints()
    }
    
    func setHierarchy() {
        signUpStackView.addArrangedSubviews(signUpLabel, signUpButton)
        
        addSubViews(
            appLogoImageView,
            appNameImageView,
            idTextfield,
            passwordTextField,
            logInButton,
            signUpStackView
        )
    }
    
    func setStyle() {
        backgroundColor = .white
        
        appLogoImageView.do {
            $0.image = UIImage(named: "logo")
            $0.contentMode = .scaleAspectFit
        }
        
        appNameImageView.do {
            $0.image = UIImage(named: "textLogo")
            $0.contentMode = .scaleAspectFit
        }
        
        idTextfield.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 25
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.placeholder = "아이디"
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
            $0.leftViewMode = .always
            $0.font = .font(.pretendardRegular, ofSize: 18)
        }
        
        passwordTextField.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 25
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.placeholder = "비밀번호"
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
            $0.leftViewMode = .always
            $0.font = .font(.pretendardRegular, ofSize: 18)
        }
        
        logInButton.do {
            $0.setTitle("로그인", for: .normal)
            $0.backgroundColor = .primary
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 25
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .font(.pretendardBold, ofSize: 18)
        }
        
        signUpLabel.do {
            $0.text = "회원이 아니신가요?"
            $0.font = .font(.pretendardRegular, ofSize: 12)
        }
        
        signUpButton.do {
            $0.setTitle("회원가입", for: .normal)
            $0.setTitleColor(.primary, for: .normal)
            $0.titleLabel?.font = .font(.pretendardRegular, ofSize: 12)
        }
        
        signUpStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
        }
    }
    
    func setConstraints() {
        appLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(150)
        }
        
        appNameImageView.snp.makeConstraints {
            $0.top.equalTo(appLogoImageView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(200)
        }
        
        idTextfield.snp.makeConstraints {
            $0.top.equalTo(appNameImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextfield.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
        
        logInButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
        
        signUpStackView.snp.makeConstraints {
            $0.top.equalTo(logInButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
}
