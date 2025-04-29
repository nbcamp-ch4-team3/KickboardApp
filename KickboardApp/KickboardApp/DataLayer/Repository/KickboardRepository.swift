//
//  KickboardRepository.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import Foundation

final class KickboardRepository: KickboardRepositoryProtocol {
    private let coreData: KickboardCoreDataProtocol

    init(coreData: KickboardCoreDataProtocol) {
        self.coreData = coreData
    }

    func saveKickboard(user: User, with kickboard: Kickboard) throws {
        try coreData.saveData(user: user, with: kickboard)
    }
}
