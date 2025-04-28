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
    let locationManager = CLLocationManager()
    let mapView = NMFMapView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)
        mapView.frame = view.frame

        locationManager.delegate = self

    }

    private func askLocationPermission() {


        guard CLLocationManager.locationServicesEnabled() else {
            showRequestLocationServiceAlert()
            return
        }

        let authorizationStatus = locationManager.authorizationStatus

        checkUserCurrentLocationAuthorization(authorizationStatus)
    }

    private func checkUserCurrentLocationAuthorization(_ status: CLAuthorizationStatus) {
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

    private func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let moveToSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
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

    private func updateToCurrentPosition() {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(
            lat: locationManager.location?.coordinate.latitude ?? 0,
            lng: locationManager.location?.coordinate.longitude ?? 0
        ))
        cameraUpdate.animation = .easeIn
        DispatchQueue.main.async {
            self.mapView.moveCamera(cameraUpdate)
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
