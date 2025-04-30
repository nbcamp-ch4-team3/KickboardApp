//
//  CoreDataError.swift
//  KickboardApp
//
//  Created by 이수현 on 4/25/25.
//

import Foundation

enum CoreDataError: AppErrorProtocol {
    case saveError(Error)
    case deleteError(Error)
    case updateError(Error)
    case readError(Error)
    case entityNotFound(String)
    case notFound(String)

    var errorDescription: String? {
        return "관리자에게 문의 바랍니다"
    }

    var debugDescription: String {
        switch self {
        case .saveError(let error):
            "saveError: \(error.localizedDescription)"
        case .deleteError(let error):
            "deleteError: \(error.localizedDescription)"
        case .updateError(let error):
            "updateError: \(error.localizedDescription)"
        case .readError(let error):
            "readError: \(error.localizedDescription)"
        case .entityNotFound(let errorDescription):
            "entityNotFound: \(errorDescription)"
        case .notFound(let error):
            "notFound: \(error)"
        }
    }
}
