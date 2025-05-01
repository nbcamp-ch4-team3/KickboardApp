//
//  PageType.swift
//  KickboardApp
//
//  Created by 최안용 on 4/29/25.
//

import Foundation

enum PageType: String {
    case history
    case kickboard
    
    var navigationTitle: String {
        switch self {
        case .history:
            return "이용 내역"
        case .kickboard:
            return "내가 등록한 킥보드"
        }
    }
    
    var firstInfoTitle: String {
        switch self {
        case .history:
            return "운행 시간 : "
        case .kickboard:
            return "등록 위치 : "
        }
    }
    
    var secondInfoTitle: String {
        switch self {
        case .history:
            return "금액 : "
        case .kickboard:
            return "추가 입력 폼 : "
        }
    }
    
    var emptyMessage: String {
        switch self {
        case .history:
            return "이용 내역이 없어요ㅠㅠ"
        case .kickboard:
            return "등록한 킥보드가 없어요ㅠㅠ"
        }
    }
}
