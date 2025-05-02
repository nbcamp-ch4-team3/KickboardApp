//
//  Date+.swift
//  KickboardApp
//
//  Created by 이수현 on 5/2/25.
//

import Foundation

extension Date {
    func toShortDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR") // 필요 시 설정
        return formatter.string(from: self)
    }

    func toTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ko_KR") // 선택 사항
        return formatter.string(from: self)
    }
}
