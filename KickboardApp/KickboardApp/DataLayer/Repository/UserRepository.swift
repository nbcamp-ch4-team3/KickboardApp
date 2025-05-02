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

        guard let entity = try coreData.findUser(),
              let id = entity.id,
              let password = entity.password,
              let nickname = entity.nickname
        else {
            throw CoreDataError.entityNotFound("readMyUserInfo - nil Data")
        }
        return User(id: id, password: password, nickname: nickname)
    }
    
    func isExistUser(_ id: String) throws -> Bool {
        try coreData.isExistUser(id)
    }
    
    func validatePassword(_ password: String, for id: String) throws -> Bool {
        try coreData.validatePassword(password, for: id)
    }
    
    func saveUserInfo(_ user: User) throws {
        try coreData.saveUser(user)
    }

    func isUsedKickboard() throws -> Bool {
        UserDefaults.standard.bool(forKey: UserDefaultsKey.isRiding.rawValue)
    }
}

