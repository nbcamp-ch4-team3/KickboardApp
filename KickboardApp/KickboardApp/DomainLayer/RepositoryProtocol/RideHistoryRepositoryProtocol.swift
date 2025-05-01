//
//  RideHistoryRepositoryProtocol.swift
//  KickboardApp
//
//  Created by 송규섭 on 5/1/25.
//

import Foundation

protocol RideHistoryRepositoryProtocol {
    func saveRideHistory(with rideHistory: RideHistory) throws
}
