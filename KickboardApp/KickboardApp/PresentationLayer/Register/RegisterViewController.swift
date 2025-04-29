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
    private let viewModel: RegisterViewModel

    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()

        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setProtocol()
        viewModel.action?(.getAllBrand)
    }

    private func setProtocol() {
        registerView.setKickboardSettingViewDelegate(self)
        registerView.setCameraDelegate(self)

        viewModel.delegate = self
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

extension RegisterViewController: RegisterViewModelDelegate {
    func didGetAllBrand(_ brands: [Brand]) {
        registerView.setDataSource(brands: brands)
    }
    
    func didFailWithError(_ error: AppError) {
        self.showErrorAlert(error: error)
    }
}
