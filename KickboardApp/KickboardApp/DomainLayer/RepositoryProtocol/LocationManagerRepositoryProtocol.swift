//
//  LocationManagerRepositoryProtocol.swift
//  KickboardApp
//
//  Created by 이수현 on 5/1/25.
//

import CoreLocation

protocol LocationManagerRepositoryProtocol {
    func addDelegate(_ delegate: LocationManagerRepositoryDelegate)
    func getCurrentLocation() -> CLLocation?
}
