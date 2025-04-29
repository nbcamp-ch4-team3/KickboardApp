//
//  RegisterViewController.swift
//  KickboardApp
//
//  Created by 이수현 on 4/28/25.
//

import UIKit
import NMapsMap

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
        registerView.setCameraDelegate(self)
    }
}

extension RegisterViewController: KickboardSettingViewDelegate {
    func didTapRegisterButton(latitude: Double, longitude: Double, brand: Brand, battery: Int) {
        print("latitude: \(latitude), longitude: \(longitude), brand: \(brand), battery: \(battery)")
    }
}

extension RegisterViewController: NMFMapViewCameraDelegate {
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        let location = mapView.cameraPosition.target
        registerView.configure(location: location)
    }
}
