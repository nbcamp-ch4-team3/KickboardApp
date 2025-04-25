//
//  UIStackView+.swift
//  KickboardApp
//
//  Created by 최안용 on 4/25/25.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
