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
    func fetchAllKickboards() throws
    func nearbyKickboards(from location: CLLocation, within meters: Double) -> [Kickboard]
}

protocol HomeViewModelDelegate: AnyObject {
    func didUpdateLocals(locals: [Local])
    func didFailWithError(_ error: AppError)
}

final class HomeViewModel: HomeViewModelProtocol, ViewModelProtocol {
    private let useCase: HomeUseCaseProtocol
    var mockKickboards: [Kickboard] = []
    weak var delegate: HomeViewModelDelegate?
    var kickboards: [Kickboard] = []

    var action: ((Action) -> Void)?

    enum Action {
        case fetchSearchResult(String)
    }

    init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase

        action = {[weak self] action in
            switch action {
            case .fetchSearchResult(let query):
                self?.fetchSearchResult(query: query)
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

    func fetchAllKickboards() throws {
        do {
            self.kickboards = try useCase.getAllKickboard()
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
                let locals = try await useCase.fetchSearchResult(query: query)
                delegate?.didUpdateLocals(locals: locals)
            } catch {
                delegate?.didFailWithError(AppError(error))
            }
        }
    }
}
