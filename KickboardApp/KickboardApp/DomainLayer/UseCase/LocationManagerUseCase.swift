//
//  LocationManagerUseCase.swift
//  KickboardApp
//
//  Created by 이수현 on 5/1/25.
//

import CoreLocation

protocol LocationManagerUseCaseProtocol {
    func addDelegate(_ delegate: LocationManagerRepositoryDelegate)
    func getCurrentLocation() -> CLLocation?
}

final class LocationManagerUseCase: LocationManagerUseCaseProtocol {
    private let locationManagerRepository: LocationManagerRepositoryProtocol

    init(
        locationManagerRepository: LocationManagerRepositoryProtocol
    ) {
        self.locationManagerRepository = locationManagerRepository
    }

    func addDelegate(_ delegate: any LocationManagerRepositoryDelegate) {
        locationManagerRepository.addDelegate(delegate)
    }

    func getCurrentLocation() -> CLLocation? {
        locationManagerRepository.getCurrentLocation()
    }
}
