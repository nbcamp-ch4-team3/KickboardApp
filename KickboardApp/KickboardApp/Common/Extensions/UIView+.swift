//
//  UIView+.swift
//  KickboardApp
//
//  Created by 최안용 on 4/25/25.
//

import UIKit

extension UIView {
    func addsubViews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
