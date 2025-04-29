//
//  ListType.swift
//  KickboardApp
//
//  Created by 최안용 on 4/29/25.
//

import Foundation

enum ListType: String {
    case history = "이용 내역"
    case kickboard = "내가 등록한 킥보드"
    case logout = "로그아웃"
    
    var isTrailingIcon: Bool {
        switch self {
        case .history, .kickboard:
            return false
        default:
            return true
        }
    }
    
    var leadingIconName: String {
        switch self {
        case .history:
            return "ic_history"
        case .kickboard:
            return "ic_kickboard"
        case .logout:
            return "ic_logout"
        }
    }
    
    var trailingIconName: String {
        return "ic_next"
    }
    
    var leadingIconWidth: CGFloat {
        switch self {
        case .history:
            return 23
        case .kickboard:
            return 30
        case .logout:
            return 28
        }
    }
    
    var leadingSpacing: CGFloat {
        switch self {
        case .history:
            return 26
        case .kickboard:
            return 22
        case .logout:
            return 27
        }
    }
    
    var leadingIconHeight: CGFloat {
        switch self {
        case .history:
            return 25
        case .kickboard:
            return 24
        case .logout:
            return 24
        }
    }
    
    var titleLeadingSpacing: CGFloat {
        switch self {
        case .history:
            return 17
        case .kickboard:
            return 14
        case .logout:
            return 11
        }
    }
    
    var isRedColor: Bool {
        switch self {
        case .logout:
            return true
        default:
            return false
        }
    }
}
