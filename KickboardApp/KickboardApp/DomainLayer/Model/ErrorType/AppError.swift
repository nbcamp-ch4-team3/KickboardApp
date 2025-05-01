//
//  AppError.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import Foundation

protocol AppErrorProtocol: LocalizedError {
    var errorDescription: String? { get }
    var debugDescription: String { get }
}

enum AppError: AppErrorProtocol {
    case networkError(NetworkError)
    case coreDataError(CoreDataError)
    case userDefaultsError(UserDefaultsError)
    case unKnown(Error)

    init(_ error: Error) {
        switch error {
        case let error as NetworkError:
            self = .networkError(error)
        case let error as CoreDataError:
            self = .coreDataError(error)
        case let error as UserDefaultsError:
            self = .userDefaultsError(error)
        default:
            self = .unKnown(error)
        }
    }

    var errorDescription: String? {
        switch self {
        case .networkError(let error as AppErrorProtocol),
             .coreDataError(let error as AppErrorProtocol),
             .userDefaultsError(let error as AppErrorProtocol):
            return error.errorDescription
        default:
            return "알 수 없는 오류가 발생했습니다."
        }
    }

    var debugDescription: String {
        switch self {
        case .networkError(let error as AppErrorProtocol),
             .coreDataError(let error as AppErrorProtocol),
             .userDefaultsError(let error as AppErrorProtocol):
            error.debugDescription
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
        case .networkError:
            return .networkError
        default:
            return .defaultError
        }
    }
}
