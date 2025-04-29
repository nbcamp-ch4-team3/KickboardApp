//
//  LogInViewController.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/28/25.
//

import UIKit

final class LogInViewController: UIViewController {
    private let logInView = LogInView()
    private let viewModel: LogInViewModel
    
    init(viewModel: LogInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "compile error")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = logInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    @objc func logInButtonTapped() {
        print("Login In Button Tapped!")
        
        validate()
    }
    
    @objc func signUpButtonTapped() {
        print("Sign Up Button Tapped!")
        
        let viewController = SignUpViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func validate() {
        let id = logInView.idTextfield.text ?? ""
        let password = logInView.passwordTextField.text ?? ""
        
        print("id: \(id), password: \(password)")
        
        let result = viewModel.validate(id: id, password: password)
        
        switch result {
        case .valid:
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.window?.rootViewController = TabBarController()
        case .invalid(let message):
            showError(message: message)
            logInView.idTextfield.text = ""
            logInView.passwordTextField.text = ""
        }
    }
    
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
}

extension LogInViewController {
    func configure() {
        setAction()
    }
    
    func setAction() {
        logInView.logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        logInView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
}
