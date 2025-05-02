//
//  LocationManagerRepository.swift
//  KickboardApp
//
//  Created by 이수현 on 5/1/25.
//

import CoreLocation
import UIKit

protocol LocationManagerRepositoryDelegate: AnyObject {
    func didUpdateLocation(_ location: CLLocation)
    func showRequestLocationServiceAlert(_ alertController: UIAlertController)
}

final class LocationManagerRepository: NSObject, LocationManagerRepositoryProtocol {
    private let locationManager: CLLocationManager
    private var delegates = NSHashTable<AnyObject>.weakObjects()

    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
    }

    func addDelegate(_ delegate: any LocationManagerRepositoryDelegate) {
        if delegates.allObjects.isEmpty {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }

        if !delegates.allObjects.contains(where: { $0 === delegate }) {
            delegates.add(delegate)
        }
    }

    func getCurrentLocation() -> CLLocation? {
        return locationManager.location
    }
}

extension LocationManagerRepository: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }

        for case let delegate as LocationManagerRepositoryDelegate in delegates.allObjects {
            delegate.didUpdateLocation(currentLocation)
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.global().async {
            self.askLocationPermission()
        }
    }
}

private extension LocationManagerRepository {
    func askLocationPermission() {
        guard CLLocationManager.locationServicesEnabled() else {
            //TODO: 위치 정보 얼럿 띄우기 딜리게이트 호출
            for case let delegate as LocationManagerRepositoryDelegate in delegates.allObjects {
                DispatchQueue.main.async {
                    let alert = self.makeRequestLocationServiceAlert()
                    delegate.showRequestLocationServiceAlert(alert)
                }
            }
            return
        }

        let authorizationStatus = locationManager.authorizationStatus

        checkUserCurrentLocationAuthorization(authorizationStatus)
    }

    func checkUserCurrentLocationAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            for case let delegate as LocationManagerRepositoryDelegate in delegates.allObjects {
                DispatchQueue.main.async {
                    let alert = self.makeRequestLocationServiceAlert()
                    delegate.showRequestLocationServiceAlert(alert)
                }
            }
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            return
        }
    }

    func makeRequestLocationServiceAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: "위치 정보 이용",
            message: "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.",
            preferredStyle: .alert
        )
        let moveToSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            // TODO: - 앱 설정 맨 첫 페이지로 이동하는 방법 찾아야함. 앱 scheme,
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                DispatchQueue.main.async {
                    UIApplication.shared.open(appSetting)
                }
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)

        alert.addAction(cancel)
        alert.addAction(moveToSetting)
        return alert
    }
}
