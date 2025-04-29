//
//  RegisterTitleView.swift
//  KickboardApp
//
//  Created by 이수현 on 4/28/25.
//

import UIKit

final class RegisterTitleView: UIView {
    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()

    init() {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RegisterTitleView {
    func configure() {
        setHierarchy()
        setStyle()
        setConstraints()
    }

    func setHierarchy() {
        self.addSubViews(logoImageView, titleLabel)
    }

    func setStyle() {
        self.backgroundColor = .white
        
        logoImageView.do {
            $0.image = .logo
        }

        titleLabel.do {
            $0.textColor = .black2
            $0.font = .font(.pretendardBold, ofSize: 21)

            let text = "킥보드 위치 등록"
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(
                .foregroundColor,
                value: UIColor.primary ?? .black,
                range: (text as NSString).range(of: "킥보드")
            )
            $0.attributedText = attributedText
        }
    }

    func setConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.trailing.equalTo(titleLabel.snp.leading)
            make.size.equalTo(36)
        }

        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
