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
    func didUpdateSerachResult(locals: [Local])
    func didFailWithError(_ error: AppError)

    func didSaveRideHistory()
    func didUpdateSelectedKickboard(kickboard: Kickboard)
    func didUpdateKickboards(kickboards: [Kickboard])
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
        case updateKickboardLocation(UUID)
        case didSelectLocal(Local)
        case setUserLocation
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
            case .updateKickboardLocation(let id):
                self.updateKickboardLocation(id: id)
            case .didSelectLocal(let local):
                self.didSelectLocal(local: local)
            case .setUserLocation:
                self.setUserLocation()
            }
        }
    }

    private func setUserLocation() {
        if let location = locationManagerUseCase.getCurrentLocation() {
            delegate?.didUpdateLocation(location)
        }
    }

    private func fetchKickboards() throws {
        do {
            self.kickboards = try homeUseCase.getAllKickboard()
            if let location = locationManagerUseCase.getCurrentLocation() {
                nearbyKickboards(from: location, within: 1000)
            }
        } catch {
            throw CoreDataError.readError(error)
        }
    }

    private func didSelectLocal(local: Local) {
        let location = CLLocation(latitude: local.latitude, longitude: local.longitude)
        nearbyKickboards(from: location, within: 1000)
    }

    private func nearbyKickboards(from location: CLLocation, within meters: Double) {
        let nearbyKickboards = kickboards.filter { kickboard in
            let kickboardLocation = CLLocation(latitude: kickboard.latitude, longitude: kickboard.longitude)
            return location.distance(from: kickboardLocation) <= meters
        }

        delegate?.didUpdateKickboards(kickboards: nearbyKickboards)
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
            _ = try homeUseCase.saveRideHistory(with: rideHistory)
            delegate?.didSaveRideHistory()
        } catch {
            delegate?.didFailWithError(AppError(error))
        }
    }

    private func updateKickboardLocation(id: UUID) {
        do {
            guard let location = locationManagerUseCase.getCurrentLocation()?.coordinate else { return }
            try homeUseCase.updateKickboardLocation(id: id, latitude: location.latitude, longitude: location.longitude)
        } catch {
            delegate?.didFailWithError(AppError(error))
        }
    }
}

extension HomeViewModel: LocationManagerRepositoryDelegate {
    func didUpdateLocation(_ location: CLLocation) {
        print(#function)
        delegate?.didUpdateLocation(location)
        nearbyKickboards(from: location, within: 1000)
    }

    func showRequestLocationServiceAlert(_ alertController: UIAlertController) {
        delegate?.didRequestLocationServiceAlert(alertController)
    }
}
