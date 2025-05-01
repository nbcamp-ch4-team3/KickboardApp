//
//  HomeViewModel.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/30/25.
//

import UIKit
import CoreLocation

protocol HomeViewModelDelegate: AnyObject {
    func didUpdateLocation(_ location: CLLocation)
    func didRequestLocationServiceAlert(_ alert: UIAlertController)
    func didUpdateSelectedKickboard(kickboard: Kickboard)
    func didSaveRideHistory()
    func didUpdateSerachResult(locals: [Local])
}

final class HomeViewModel: ViewModelProtocol {
    private let locationManagerUseCase: LocationManagerUseCaseProtocol
    private let homeUseCase: HomeUseCaseProtocol
    weak var delegate: HomeViewModelDelegate?

    var mockKickboards: [Kickboard] = []
    var kickboards: [Kickboard] = []
    var selectedKickboard: Kickboard? {
        didSet {
            guard let selectedKickboard else { return }
            delegate?.didUpdateSelectedKickboard(kickboard: selectedKickboard)
        }
    }

    var action: ((Action) -> Void)?

    enum Action {
        case fetchSearchResult(String)
        case fetchKickboards
        case saveRideHistory(RideHistory)
    }

    init(
        homeUseCase: HomeUseCaseProtocol,
        locationManagerUseCase: LocationManagerUseCaseProtocol
    ) {
        self.homeUseCase = homeUseCase
        self.locationManagerUseCase = locationManagerUseCase

        locationManagerUseCase.addDelegate(self)

        action = {[weak self] action in
            guard let self else { return }
            switch action {
            case .fetchSearchResult(let query):
                self.fetchSearchResult(query: query)
            case .fetchKickboards:
                do {
                    try self.fetchKickboards()
                } catch {
                    self.delegate?.didFailWithError(AppError(error))
                }
            case .saveRideHistory(let history):
                self.saveRideHistory(with: history)
            }
        }
    }

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

    private func fetchKickboards() throws {
        do {
            self.kickboards = try useCase.getAllKickboard()
            delegate?.didUpdateKickboards(kickboards: kickboards)
        } catch {
            throw CoreDataError.readError(error)
        }
    }

    func nearbyKickboards(from location: CLLocation, within meters: Double) -> [Kickboard] {
        return kickboards.filter { kickboard in
            let kickboardLocation = CLLocation(latitude: kickboard.latitude, longitude: kickboard.longitude)
            return location.distance(from: kickboardLocation) <= meters
        }
    }

    private func fetchSearchResult(query: String) {
        Task {
            do {
                let locals = try await homeUseCase.fetchSearchResult(query: query)
                delegate?.didUpdateSerachResult(locals: locals)
            } catch {
                delegate?.didFailWithError(AppError(error))
            }
        }
    }

    private func saveRideHistory(with rideHistory: RideHistory) {
        do {
            _ = try useCase.saveRideHistory(with: rideHistory)
            delegate?.didSaveRideHistory()
        } catch {
            delegate?.didFailWithError(AppError(error))
        }
    }
}

extension HomeViewModel: LocationManagerRepositoryDelegate {
    func didUpdateLocation(_ location: CLLocation) {
        delegate?.didUpdateLocation(location)
    }

    func showRequestLocationServiceAlert(_ alertController: UIAlertController) {
        delegate?.didRequestLocationServiceAlert(alertController)
    }
}
