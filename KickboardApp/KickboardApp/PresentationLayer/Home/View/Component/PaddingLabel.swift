//
//  PaddingLabel.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/29/25.
//

import UIKit

class PaddingLabel: UILabel {
    var inset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8) // 기본 값

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(inset: UIEdgeInsets) {
        self.inset = inset
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: inset))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + inset.left + inset.right,
                      height: size.height + inset.top + inset.bottom)
    }
}
