//
//  SignUpViewController.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/28/25.
//

import UIKit

final class SignUpViewController: UIViewController {
    let status: SignUpStatus
    
    private let signUpView = SignUpView()
    private let viewModel = SignUpViewModel()
    
    init(status: SignUpStatus) {
        self.status = status
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
    
    @objc func buttonTapped() {
        switch status {
        case .id:
            let viewController = SignUpViewController(status: .password)
            viewController.signUpView.configure(with: .password)
            navigationController?.pushViewController(viewController, animated: true)
        case .password:
            let viewController = SignUpViewController(status: .nickname)
            viewController.signUpView.configure(with: .nickname)
            navigationController?.pushViewController(viewController, animated: true)
        case .nickname:
            showError(message: "다시 로그인 해주세요.")
        }
    }
    
    private func showError(message: String) {
        let alertTitle = NSLocalizedString("회원가입 완료", comment: "Error alert title")
        let alert = UIAlertController(
            title: alertTitle, message: message, preferredStyle: .alert)
        let actionTitle = NSLocalizedString("확인", comment: "Alert OK button title")
        alert.addAction(
            UIAlertAction(
                title: actionTitle, style: .default,
                handler: { [weak self] _ in
                    // self?.dismiss(animated: true)
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
    }
}
