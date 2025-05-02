//
//  UserRepositoryProtocol.swift
//  KickboardApp
//
//  Created by 최안용 on 4/25/25.
//

import Foundation

protocol UserRepositoryProtocol {
    func readMyUserInfo() throws -> User
    func isExistUser(_ id: String) throws -> Bool
    func validatePassword(_ password: String, for id: String) throws -> Bool
    func saveUserInfo(_ user: User) throws
    func isUsedKickboard() throws -> Bool
}
