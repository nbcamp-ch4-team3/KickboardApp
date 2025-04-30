//
//  LocalDTO.swift
//  KickboardApp
//
//  Created by 이수현 on 4/30/25.
//

import Foundation

struct LocalDTO: Codable {
    let total: Int
    let start: Int
    let display: Int
    let items: [LocalItemDTO]
}

struct LocalItemDTO: Codable {
    let title: String
    let category: String
    let description: String
    let address: String     // 지번 주소
    let roadAddress: String // 도로명 주소
    let mapx: String
    let mapy: String
}
