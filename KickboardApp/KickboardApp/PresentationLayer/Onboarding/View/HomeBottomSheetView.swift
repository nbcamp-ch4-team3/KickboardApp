//
//  HomeBottomSheetView.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/29/25.
//

import UIKit

final class HomeBottomSheetView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

}

private extension HomeBottomSheetView {
    func configure() {
        setStyle()
        setHierarchy()
        setConstraints()
        setAction()
    }

    func setStyle() {
        backgroundColor = .gray
    }

    func setHierarchy() {

    }

    func setConstraints() {

    }

    func setAction() {

    }
}

