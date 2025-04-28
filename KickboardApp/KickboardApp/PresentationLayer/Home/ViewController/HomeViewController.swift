//
//  HomeViewController.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/25/25.
//

import UIKit
import NMapsMap
import CoreLocation

class HomeViewController: UIViewController {
    private let homeView = HomeView()
    let locationManager = CLLocationManager()

    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        homeView.delegate = self
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
        case .authorizedWhenInUse:
            print("authroizedWhenInUse")
            locationManager.startUpdatingLocation()
            updateToCurrentPosition()
        default:
            return
        }
    }

    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
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
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(
            lat: locationManager.location?.coordinate.latitude ?? 0,
            lng: locationManager.location?.coordinate.longitude ?? 0
        ))
        cameraUpdate.animation = .easeIn
        DispatchQueue.main.async {
            self.homeView.moveCamera(to: cameraUpdate)
        }
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
    func didTapMarker() {
        print("didTapKickboard")
        let vc = HomeBottomSheetViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(vc, animated: true)
    }
}
