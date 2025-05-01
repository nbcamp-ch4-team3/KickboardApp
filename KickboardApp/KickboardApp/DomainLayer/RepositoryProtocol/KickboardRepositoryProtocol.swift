//
//  KickboardRepositoryProtocol.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import Foundation

protocol KickboardRepositoryProtocol {
    func saveKickboard(with kickboard: Kickboard) throws -> Void
    func getAllKickboard() throws -> [Kickboard]
    func updateLocation(id: UUID, latitude: Double, longitude: Double) throws
}
