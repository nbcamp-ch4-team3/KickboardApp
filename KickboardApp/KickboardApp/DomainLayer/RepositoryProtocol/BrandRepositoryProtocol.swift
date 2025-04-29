//
//  BrandRepositoryProtocol.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import Foundation

protocol BrandRepositoryProtocol {
    func getAllBrand() throws -> [Brand]
}
