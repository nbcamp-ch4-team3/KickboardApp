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

        homeView.delegate = self
        viewModel.delegate = self

        viewModel.action?(.fetchKickboards)

        restoreIsRidingState()
    }

    // 앱 진입 시 이용 중인지에 대해 분기 처리
    private func restoreIsRidingState() {
        let isRiding = UserDefaults.standard.bool(forKey: "isRiding")

        if isRiding,
           let data = UserDefaults.standard.data(forKey: "kickboard"),
           let startTime = UserDefaults.standard.object(forKey: "startTime") as? Date,
           let kickboard = try? JSONDecoder().decode(Kickboard.self, from: data) {

            let startTimeString = DateUtility.shared.toHourAndMinuteString(from: startTime)
            homeView.configureRentalStatusView(kickboard: kickboard, startTime: startTimeString)
        } else {
            handleKickboardReturn()
        }

        homeView.switchView(isRiding: isRiding)
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

    func handleKickboardReturn() {
        homeView.switchView(isRiding: false)
        homeView.setMarkersByState(isRented: false)
        viewModel.selectedKickboard = nil

        if UserDefaults.standard.bool(forKey: "isRiding"),
           let startTime = UserDefaults.standard.object(forKey: "startTime") as? Date,
           let data = UserDefaults.standard.data(forKey: "kickboard"),
           let kickboard = try? JSONDecoder().decode(Kickboard.self, from: data) {
            let endTime = Date.now
            let timeDiff = DateUtility.shared.minutesBetween(start: startTime, end: endTime)
            let totalPrice = timeDiff * kickboard.brand.pricePerMinute

            let rideHistory = RideHistory(
                kickboard: kickboard,
                startTime: startTime,
                endTime: endTime,
                price: totalPrice
            )

            viewModel.action?(.saveRideHistory(rideHistory))
        }

        // 기존 저장되어있던 대여 정보 제거
        let keys = [
            "isRiding",
            "startTime",
            "kickboard",
        ]
        keys.forEach { UserDefaults.standard.removeObject(forKey: $0) }
    }

}


// TODO: - 앱 실행 시 Location 권한 요청 -> 온보딩 구현 -> 로그인 후

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.global().async {
            self.askLocationPermission()
        }
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapSearchButton(with textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        viewModel.action?(.fetchSearchResult(text))
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

    func didTapMarker(with kickboard: Kickboard) {
        viewModel.selectedKickboard = kickboard
    }

    func didTapMarkerVisibleButton() {
        homeView.toggleMarkersVisibility()
    }

    func didTapReturnButton() {
        let alert = UIAlertController(
            title: "킥보드를 반납하시겠어요?",
            message: "이용이 종료되며, 반납 처리 및 요금 정산이 진행됩니다.\n반납하시겠습니까?",
            preferredStyle: .alert
        )
        let confirm = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self else { return }
            self.handleKickboardReturn()
            self.dismiss(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(confirm)
        alert.addAction(cancel)

        present(alert, animated: true)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didSaveRideHistory() {
        print("saveRideHistory 저장 완료")
    }
    
    func didUpdateSelectedKickboard(kickboard: Kickboard) {
        let vc = HomeBottomSheetViewController()
        vc.delegate = self

        guard let selectedKickboard = viewModel.selectedKickboard else { return }
        vc.configure(with: selectedKickboard)

        var options = SheetOptions()
        // 라이브러리 기본 옵션을 취소하는 설정들
        options.shrinkPresentingViewController = false
        options.useFullScreenMode = false
        options.shouldExtendBackground = false

        let sheetVC = SheetViewController(controller: vc, sizes: [.intrinsic], options: options) // 내부 컴포넌트 크기에 의한 높이 계산

        present(sheetVC, animated: true)
    }
    
    func didUpdateKickboards(kickboards: [Kickboard]) {
        DispatchQueue.main.async {
            self.homeView.updateKickboardMarkers(with: kickboards)
        }
    }

extension HomeViewController: HomeViewModelDelegate {

    func didUpdateSerachResult(locals: [Local]) {
        DispatchQueue.main.async {
            self.homeView.setSearchResult(locals: locals)
        }
    }

    func didFailWithError(_ error: AppError) {
        DispatchQueue.main.async {
            self.showErrorAlert(error: error)
        }
    }

    func didUpdateLocation(_ location: CLLocation) {
        let userLocation = NMGLatLng(
            lat: location.coordinate.latitude,
            lng: location.coordinate.longitude
        )
        DispatchQueue.main.async {
            self.homeView.updateUserOverlay(to: userLocation)
        }
    }

    func didRequestLocationServiceAlert(_ alert: UIAlertController) {
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

extension HomeViewController: HomeBottomSheetVCDelegate {
    func didBottomSheetDismissed() {
        viewModel.selectedKickboard = nil
    }
    
    func didTapConfirmButton() {
        homeView.switchView(isRiding: true)
        homeView.setMarkersByState(isRented: true)

        guard let selectedKickboard = viewModel.selectedKickboard else { return }
        let startTime = Date.now
        let startTimeToString = DateUtility.shared.toHourAndMinuteString(from: startTime)
        homeView.configureRentalStatusView(
            kickboard: selectedKickboard,
            startTime: startTimeToString
        )

        UserDefaults.standard.set(true, forKey: "isRiding")
        UserDefaults.standard.set(startTime, forKey: "startTime")
        if let encoded = try? JSONEncoder().encode(selectedKickboard) {
            UserDefaults.standard.set(encoded, forKey: "kickboard")
        }
    }
}
