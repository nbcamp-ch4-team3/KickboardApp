//
//  UserRepositoryProtocol.swift
//  KickboardApp
//
//  Created by 최안용 on 4/25/25.
//

import Foundation

protocol UserRepositoryProtocol {
    func readMyUserInfo() throws -> User
}
