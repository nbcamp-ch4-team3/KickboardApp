//
//  HomeViewController.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/25/25.
//

import UIKit
import NMapsMap
import CoreLocation
import FittedSheets

final class HomeViewController: UIViewController {
    private let homeView = HomeView()
    private let viewModel: HomeViewModel
    let locationManager = CLLocationManager()

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        homeView.delegate = self
        viewModel.delegate = self

//        homeViewModel.generateMockKickboards()
        try? loadData()
    }

    private func loadData() throws {
        do {
            try viewModel.fetchAllKickboards()
        } catch {
            throw CoreDataError.readError(error)
        }
    }

}

private extension HomeViewController {
    func askLocationPermission() {
        guard CLLocationManager.locationServicesEnabled() else {
            showRequestLocationServiceAlert()
            return
        }

        let authorizationStatus = locationManager.authorizationStatus

        checkUserCurrentLocationAuthorization(authorizationStatus)
    }

    func checkUserCurrentLocationAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            showRequestLocationServiceAlert()
        case .authorizedWhenInUse, .authorizedAlways:
            print("authroizedWhenInUse")
            locationManager.startUpdatingLocation()
            updateToCurrentPosition()
        default:
            return
        }
    }

    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(
            title: "위치 정보 이용",
            message: "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.",
            preferredStyle: .alert
        )
        let moveToSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            // TODO: - 앱 설정 맨 첫 페이지로 이동하는 방법 찾아야함. 앱 scheme,
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                print(appSetting)
                Task {
                    await UIApplication.shared.open(appSetting)
                }

            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default) { _ in
            return
        }

        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(moveToSetting)

        DispatchQueue.main.async {
            self.present(requestLocationServiceAlert, animated: true)
        }
    }

    func updateToCurrentPosition() {
        let cameraUpdate = NMGLatLng(
            lat: locationManager.location?.coordinate.latitude ?? 0,
            lng: locationManager.location?.coordinate.longitude ?? 0
        )
        DispatchQueue.main.async {
            self.homeView.moveCamera(to: cameraUpdate)
        }
    }
}


// TODO: - 앱 실행 시 Location 권한 요청 -> 온보딩 구현 -> 로그인 후

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { print("마지막 위치 정보 없음"); return }
        let filteredKickboards = viewModel.nearbyKickboards(from: currentLocation, within: 300)
        DispatchQueue.main.async {
            self.homeView.updateKickboardMarkers(with: filteredKickboards)
        }
    }


    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        DispatchQueue.global().async {
            self.askLocationPermission()
//        }
    }

}

extension HomeViewController: HomeViewDelegate {
    func didTapSearchButton(with textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        viewModel.action?(.fetchSearchResult(text))
    }
    
    func didTapMarker(with kickboard: Kickboard) {
        let vc = HomeBottomSheetViewController()
        vc.kickboard = kickboard

        var options = SheetOptions()
        // 라이브러리 기본 옵션을 취소하는 설정들
        options.shrinkPresentingViewController = false
        options.useFullScreenMode = false
        options.shouldExtendBackground = false

        let sheetVC = SheetViewController(controller: vc, sizes: [.intrinsic], options: options) // 내부 컴포넌트 크기에 의한 높이 계산

        present(sheetVC, animated: true)
    }

    func didSelectLocal(with local: Local) {
        let cameraUpdate = NMGLatLng(
            lat: local.latitude,
            lng: local.longitude
        )
        DispatchQueue.main.async {
            self.homeView.moveCamera(to: cameraUpdate)
        }
    }
}

extension HomeViewController: HomeViewModelDelegate {

    func didUpdateLocals(locals: [Local]) {
        DispatchQueue.main.async {
            print("didUpdateLocals: \(locals)")
            self.homeView.setSearchResult(locals: locals)
        }
    }

    func didFailWithError(_ error: AppError) {
        DispatchQueue.main.async {
            self.showErrorAlert(error: error)
        }
    }
}
