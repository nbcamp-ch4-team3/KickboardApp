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
        [signUpLabel, signUpButton].forEach {
            signUpStackView.addArrangedSubview($0)
        }
        
        [appLogoImageView,
         appNameImageView,
         idTextfield,
         passwordTextField,
         logInButton,
         signUpStackView].forEach { addSubview($0) }
    }
    
    func setStyle() {
        backgroundColor = .white
        
        appLogoImageView.do {
            $0.image = UIImage(systemName: "person.circle")
            $0.contentMode = .scaleAspectFit
        }
        
        appNameImageView.do {
            $0.image = UIImage(systemName: "person.circle")
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
        }
        
        passwordTextField.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 25
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.placeholder = "비밀번호"
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
            $0.leftViewMode = .always
        }
        
        logInButton.do {
            $0.setTitle("로그인", for: .normal)
            $0.backgroundColor = .orange
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 25
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 18)
        }
        
        signUpLabel.do {
            $0.text = "회원이 아니신가요?"
            $0.font = .systemFont(ofSize: 12)
        }
        
        signUpButton.do {
            $0.setTitle("회원가입", for: .normal)
            $0.setTitleColor(.orange, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 12)
        }
        
        signUpStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
        }
    }
    
    func setConstraints() {
        appLogoImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(40)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(100)
        }
        
        appNameImageView.snp.makeConstraints {
            $0.top.equalTo(appLogoImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(200)
        }
        
        idTextfield.snp.makeConstraints {
            $0.top.equalTo(appNameImageView.snp.bottom).offset(30)
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
