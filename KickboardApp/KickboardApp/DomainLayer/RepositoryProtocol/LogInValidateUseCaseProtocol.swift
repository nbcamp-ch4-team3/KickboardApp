//
//  LogInValidateUseCaseProtocol.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/29/25.
//

import Foundation

protocol LogInValidateUseCaseProtocol {
    func validateId(_ id: String) throws -> Bool
    func validatePassword(_ password: String, for id: String) throws -> Bool
}
