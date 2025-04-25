//
//  UIView+.swift
//  KickboardApp
//
//  Created by 최안용 on 4/25/25.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
