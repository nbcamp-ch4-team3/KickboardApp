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

    override func viewWillAppear(_ animated: Bool) {
        viewModel.action?(.getCurrentLocation)
    }

    private func setProtocol() {
        registerView.setKickboardSettingViewDelegate(self)
        viewModel.delegate = self
    }
}

extension RegisterViewController: KickboardSettingViewDelegate {
    func didTapRegisterButton(latitude: Double, longitude: Double, brand: Brand, battery: Int) {
        let kickboard = Kickboard(
            id: UUID(),
            latitude: latitude,
            longitude: longitude,
            battery: battery,
            isAvailable: true,
            brand: brand
        )
        viewModel.action?(.saveKickboard(kickboard))
    }
}

extension RegisterViewController: RegisterViewModelDelegate {
    
    func didUpdateBrands(_ brands: [Brand]) {
        registerView.setDataSource(brands: brands)
    }

    func didSaveKickboard() {
        self.showAlert(title: "등록 성공", message: "킥보드가 등록되었습니다.")
    }

    func didFailWithError(_ error: AppError) {
        self.showErrorAlert(error: error)
    }

    func didUpdateLocation(_ location: CLLocation) {
        let location = NMGLatLng(
            lat: location.coordinate.latitude,
            lng: location.coordinate.longitude
        )
        registerView.moveCamera(to: location)
    }

    func didRequestLocationServiceAlert(_ alert: UIAlertController) {
        self.present(alert, animated: true)
    }
}
