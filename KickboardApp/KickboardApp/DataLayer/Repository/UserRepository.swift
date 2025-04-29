//
//  UserRepository.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import Foundation

final class UserRepository: UserRepositoryProtocol {
    private let coreData: UserCoreDataProtocol

    init(coreData: UserCoreDataProtocol) {
        self.coreData = coreData
    }

    func readMyUserInfo() throws -> User {
        let entity = try coreData.readMyUserInfo()
        guard let id = entity.id,
              let password = entity.password,
              let nickname = entity.nickname
        else {
            throw CoreDataError.entityNotFound("readMyUserInfo - nil Data")
        }
        return User(id: id, password: password, nickname: nickname)
    }
}

