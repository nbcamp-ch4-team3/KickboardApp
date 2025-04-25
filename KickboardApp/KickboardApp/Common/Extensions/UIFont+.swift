//
//  UIFont+.swift
//  KickboardApp
//
//  Created by 최안용 on 4/25/25.
//

import UIKit

extension UIFont {
    static func font(_ style: FontName, ofSize size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: style.rawValue, size: size) else {
            print("🚨\(style.rawValue) font가 등록되지 않았습니다.🚨")
            return UIFont.systemFont(ofSize: size)
        }
        
        return customFont
    }
}

enum FontName: String {
    case gmarketSansBold = "GmarketSansBold"
    case gmarketSansMedium = "GmarketSansMedium"
    case gmarketSansLight = "GmarketSansLight"
}
