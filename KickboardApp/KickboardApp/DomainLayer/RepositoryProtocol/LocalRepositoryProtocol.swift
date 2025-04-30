//
//  LocalRepositoryProtocol.swift
//  KickboardApp
//
//  Created by 이수현 on 4/30/25.
//

import Foundation

protocol LocalRepositoryProtocol {
    func fetchLocalInfo(query: String) async throws -> [Local]
}
