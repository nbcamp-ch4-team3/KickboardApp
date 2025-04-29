//
//  LogInViewController.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/28/25.
//

import UIKit

final class LogInViewController: UIViewController {
    private let logInView = LogInView()
    
    override func loadView() {
        view = logInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    @objc func logInButtonTapped() {
        print("Login In Button Tapped!")
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = TabBarController()
    }
    
    @objc func signUpButtonTapped() {
        print("Sign Up Button Tapped!")
        
        let viewController = SignUpViewController()
        navigationController?.pushViewController(viewController, animated: true)
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
