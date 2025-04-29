//
//  RegisterViewController.swift
//  KickboardApp
//
//  Created by 이수현 on 4/28/25.
//

import UIKit

final class RegisterViewController: UIViewController {
    private let registerView = RegisterView()


    override func loadView() {
        super.loadView()

        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setProtocol()
    }

    private func setProtocol() {
        registerView.setKickboardSettingViewDelegate(self)
    }
}

extension RegisterViewController: KickboardSettingViewDelegate {
    func didTapRegisterButton(latitude: Double, longitude: Double, brand: Brand, battery: Int) {
        print("latitude: \(latitude), longitude: \(longitude), brand: \(brand), battery: \(battery)")
    }
}
