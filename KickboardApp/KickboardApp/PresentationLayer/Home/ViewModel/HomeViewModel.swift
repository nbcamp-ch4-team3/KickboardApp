//
//  HomeViewModel.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/30/25.
//

import Foundation
import CoreLocation

protocol HomeViewModelProtocol: AnyObject {
    var mockKickboards: [Kickboard] { get set }

    func generateMockKickboards()
    func nearbyKickboards(from location: CLLocation, within meters: Double) -> [Kickboard]
}

final class HomeViewModel: HomeViewModelProtocol {

    var mockKickboards: [Kickboard] = []

    func generateMockKickboards() {
        mockKickboards = [
            Kickboard(
                id: UUID(),
                latitude: 34.499621,
                longitude: 126.531188,
                battery: 34,
                isAvailable: true,
                brand: Brand(
                    title: "씽씽",
                    imageName: "ssingSsing",
                    distancePerBatteryUnit: 2,
                    pricePerMinute: 190
                )
            ),
            Kickboard(
                id: UUID(),
                latitude: 33.499221,
                longitude: 126.531688,
                battery: 86,
                isAvailable: true,
                brand: Brand(
                    title: "빔",
                    imageName: "beam",
                    distancePerBatteryUnit: 3,
                    pricePerMinute: 170
                )
            ),
            Kickboard(
                id: UUID(),
                latitude: 33.498921,
                longitude: 126.530188,
                battery: 68,
                isAvailable: true,
                brand: Brand(
                    title: "킥",
                    imageName: "kick",
                    distancePerBatteryUnit: 2.5,
                    pricePerMinute: 180
                )
            ),
            Kickboard(
                id: UUID(),
                latitude: 33.500321,
                longitude: 126.532288,
                battery: 44,
                isAvailable: true,
                brand: Brand(
                    title: "씽씽",
                    imageName: "ssingSsing",
                    distancePerBatteryUnit: 2,
                    pricePerMinute: 190
                )
            )
        ]
    }

    func nearbyKickboards(from location: CLLocation, within meters: Double) -> [Kickboard] {
        return mockKickboards.filter { kickboard in
            let kickboardLocation = CLLocation(latitude: kickboard.latitude, longitude: kickboard.longitude)
            return location.distance(from: kickboardLocation) <= meters
        }
    }
}
