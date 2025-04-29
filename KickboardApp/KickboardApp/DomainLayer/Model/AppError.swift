//
//  AppError.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import Foundation

enum AppError: LocalizedError {
    case networkError(Error)
    case coreDataError(CoreDataError)
    case unKnown(Error)

    init(_ error: Error) {
        switch error {
        case let error as CoreDataError:
            self = .coreDataError(error)
        default:
            self = .unKnown(error)
        }
    }

    var errorDescription: String? {
        switch self {
        case .coreDataError(let coreDataError):
            coreDataError.errorDescription
        default:
            "알 수 없는 오류가 발생했습니다."
        }
    }

    var debugDescription: String {
        switch self {
        case .coreDataError(let coreDataError):
            coreDataError.debugDescription
        default:
            self.localizedDescription
        }
    }
}

extension AppError {
    enum AlertType: String {
        case networkError = "네트워크 오류"
        case defaultError = "오류"
    }

    var alertType: AlertType {
        switch self {
        default:
            return .defaultError
        }
    }
}
