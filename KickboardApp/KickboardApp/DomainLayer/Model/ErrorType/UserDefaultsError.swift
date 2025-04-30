//
//  UserDefaultsError.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import Foundation

enum UserDefaultsError: AppErrorProtocol {
    case invalidKey(String)

    var errorDescription: String? {
        switch self {
        case .invalidKey:
            "유저 정보를 불러오지 못했습니다."
        }
    }

    var debugDescription: String {
        switch self {
        case .invalidKey(let key):
            "UserDefaultsError - invalidKey: \(key)"
        }
    }
}
