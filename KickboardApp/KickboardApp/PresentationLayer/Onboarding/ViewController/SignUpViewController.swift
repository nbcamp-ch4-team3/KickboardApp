//
//  SignUpViewController.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/28/25.
//

import UIKit

final class SignUpViewController: UIViewController {
    private let signUpView = SignUpView()
    private let viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 사용자가 뒤로가기 버튼으로 이전 단계로 돌아가면, 뷰 모델의 회원가입 단계 상태값도 변경
        if isMovingFromParent {
            print("back button tapped")
            viewModel.back()
        }
    }
    
    @objc func buttonTapped() {
        switch viewModel.status {
        case .id:
            validateId()
        case .password:
            validatePassword()
        case .nickname:
            validateNickname()
        }
    }
    
    // ID 검증
    private func validateId() {
        let input = signUpView.textField.text
        guard let input else { return }
        let result = viewModel.validateId(input)
        
        switch result {
        case .valid: // 이상 없으면 다음 단계로 진행
            next()
        case .invalid(let message):
            showError(message: message)
            signUpView.textField.text = ""
        }
    }
    
    // 비밀번호 검증
    private func validatePassword() {
        let input = signUpView.textField.text
        let confirmInput = signUpView.confirmTextField.text
        guard let input, let confirmInput else { return }
        let result = viewModel.validatePassword(input, confirmInput)
        
        switch result {
        case .valid: // 이상 없으면 다음 단계로 진행
            next()
        case .invalid(let message):
            showError(message: message)
            signUpView.textField.text = ""
            signUpView.confirmTextField.text = ""
        }
    }
    
    // 닉네임 검증
    private func validateNickname() {
        let input = signUpView.textField.text
        guard let input else { return }
        let result = viewModel.validateNickname(input)
        
        switch result {
        case .valid: // 이상 없으면 회원정보 저장 시도
            saveUserInfo()
        case .invalid(let message):
            showError(message: message)
            signUpView.textField.text = ""
        }
    }
    
    // 회원가입 다음 단계로 이동
    private func next() {
        viewModel.next()
        let viewController = SignUpViewController(viewModel: viewModel)
        viewController.signUpView.configure(with: viewModel.status)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func saveUserInfo() {
        let result = viewModel.saveUserInfo()
        
        switch result {
        case .valid: // 회원정보 저장이 성공하면 로그인 화면으로 이동
            signUpCompleted(message: "다시 로그인 해주세요.")
        case .invalid(let message):
            showError(message: message)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // 오류 메시지
    private func showError(message: String) {
        let alertTitle = NSLocalizedString("오류", comment: "Error alert title")
        let alert = UIAlertController(
            title: alertTitle, message: message, preferredStyle: .alert)
        let actionTitle = NSLocalizedString("확인", comment: "Alert OK button title")
        alert.addAction(
            UIAlertAction(
                title: actionTitle, style: .default,
                handler: { [weak self] _ in
                    self?.dismiss(animated: true)
                }))
        present(alert, animated: true, completion: nil)
    }
    
    // 회원가입 성공 알림 및 로그인 화면 이동
    private func signUpCompleted(message: String) {
        let alertTitle = NSLocalizedString("회원가입 완료", comment: "Error alert title")
        let alert = UIAlertController(
            title: alertTitle, message: message, preferredStyle: .alert)
        let actionTitle = NSLocalizedString("확인", comment: "Alert OK button title")
        alert.addAction(
            UIAlertAction(
                title: actionTitle, style: .default,
                handler: { [weak self] _ in
                    self?.navigationController?.popToRootViewController(animated: true)
                }))
        present(alert, animated: true, completion: nil)
    }
}

extension SignUpViewController {
    func configure() {
        setStyle()
        setAction()
    }
    
    func setStyle() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    func setAction() {
        signUpView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        switch viewModel.status {
        case .password:
            signUpView.textField.button.addTarget(self, action: #selector(textFieldButtonTapped), for: .touchUpInside)
            signUpView.confirmTextField.button.addTarget(self, action: #selector(confirmTextFieldButtonTapped), for: .touchUpInside)
        default:
            break
        }
    }
    
    @objc func textFieldButtonTapped() {
        signUpView.textField.toggleSecureTextEntry()
    }
    
    @objc func confirmTextFieldButtonTapped() {
        signUpView.confirmTextField.toggleSecureTextEntry()
    }
}
