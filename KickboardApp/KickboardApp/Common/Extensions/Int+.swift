//
//  Int+.swift
//  KickboardApp
//
//  Created by 이수현 on 5/2/25.
//

import Foundation

extension Int {
    func toPriceString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let formatted = numberFormatter.string(from: NSNumber(value: self)) {
            return "\(formatted)원"
        } else {
            return "\(self)원"
        }
    }
}
