//
//  UIColor+.swift
//  KickboardApp
//
//  Created by 이수현 on 4/28/25.
//

import UIKit

extension UIColor {
    // Hex 문자열을 UIColor로 변환하는 메서드
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        // Hex 문자열 길이에 따라 RGB 값을 추출
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        // UIColor 초기화
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension UIColor {
    static let primary = UIColor(hex: "#FFA733")
    static let secondary = UIColor(hex: "#FFE0B2")
    static let black2 = UIColor(hex: "#1A1A1A")
    static let gray1 = UIColor(hex: "#3B3B3B")
    static let gray2 = UIColor(hex: "#636870")
    static let gray3 = UIColor(hex: "#C7C7C7")
    static let gray4 = UIColor(hex: "#ECECEC")
}
