//
//  SignUpViewController.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/28/25.
//

import UIKit

final class SignUpViewController: UIViewController {
    private let signUpView = SignUpView()
    
    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        signUpView.confirmTextField.isHidden = false // 비밀번호 설정 단계에서만 필요
    }
    
    @objc func buttonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController {
    func configure() {
        setStyle()
        
        signUpView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setStyle() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
    }
}
