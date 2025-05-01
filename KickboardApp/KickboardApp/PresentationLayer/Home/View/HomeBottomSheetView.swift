//
//  HomeBottomSheetView.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/29/25.
//

import UIKit

protocol HomeBottomSheetViewDelegate: AnyObject {
    func didTapRentButton()
}

final class HomeBottomSheetView: UIView {
    weak var delegate: HomeBottomSheetViewDelegate?

    private let kbBrandLabel = UILabel()
    private let kbModelLabel = UILabel()
    private let kbRemainedBatteryView = RemainedBatteryView()
    private let kbCommentLabel = UILabel() // "약 4km 주행할 수 있어요!"같은
    private let kbFeePerMinuteLabel = PaddingLabel()
    private let kbImageView = UIImageView()
    private let rentButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

    func configure(with kickboard: Kickboard) {
        self.kbBrandLabel.text = kickboard.brand.title
        self.kbModelLabel.text = String(kickboard.id.uuidString.prefix(8))
        self.kbCommentLabel.attributedText = makeComment(distance: kickboard.brand.distancePerBatteryUnit)
        self.kbFeePerMinuteLabel.text = "분당 \(kickboard.brand.pricePerMinute)원"
        self.kbImageView.image = UIImage(named: "\(kickboard.brand.imageName)")
        self.kbRemainedBatteryView.configure(with: kickboard.battery)
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
        backgroundColor = .white

        kbBrandLabel.do {
            $0.font = UIFont(name: "Pretendard-SemiBold", size: 23)
            $0.textColor = .black
            $0.textAlignment = .left
        }

        kbModelLabel.do {
            $0.font = UIFont(name: "Pretendard-Medium", size: 19)
            $0.textColor = .black
            $0.textAlignment = .left
        }

        kbCommentLabel.do {
            $0.font = UIFont(name: "Pretendard-Medium", size: 15)
            $0.textColor = .black
            $0.textAlignment = .left
        }

        kbFeePerMinuteLabel.do {
            $0.layer.cornerRadius = 5
            $0.clipsToBounds = true
            $0.backgroundColor = .gray4
            $0.font = UIFont(name: "Pretendard-Regular", size: 12)
            $0.textColor = .black
        }

        kbImageView.do {
            $0.backgroundColor = .gray3
            $0.layer.cornerRadius = 10
        }

        rentButton.do {
            $0.backgroundColor = .primary
            $0.layer.cornerRadius = 10
            $0.setTitle("대여하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
        }
    }

    func setHierarchy() {
        addSubViews(kbBrandLabel, kbModelLabel, kbRemainedBatteryView, kbCommentLabel, kbFeePerMinuteLabel, kbImageView, rentButton)
    }

    func setConstraints() {
        kbBrandLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.leading.equalToSuperview().inset(32)
            $0.width.equalTo(100)
        }

        kbModelLabel.snp.makeConstraints {
            $0.top.equalTo(kbBrandLabel.snp.bottom).offset(8)
            $0.leading.equalTo(kbBrandLabel)
            $0.width.equalTo(100)
        }

        kbRemainedBatteryView.snp.makeConstraints {
            $0.top.equalTo(kbBrandLabel)
            $0.leading.equalTo(kbBrandLabel.snp.trailing).offset(12)
            $0.width.equalTo(20)
        }

        kbCommentLabel.snp.makeConstraints {
            $0.top.equalTo(kbModelLabel.snp.bottom).offset(12)
            $0.leading.equalTo(kbBrandLabel)
        }

        kbFeePerMinuteLabel.snp.makeConstraints {
            $0.top.equalTo(kbCommentLabel.snp.bottom).offset(12)
            $0.leading.equalTo(kbBrandLabel)
        }

        kbImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.trailing.equalToSuperview().inset(32)
            $0.size.equalTo(72)
        }

        rentButton.snp.makeConstraints {
            $0.top.equalTo(kbFeePerMinuteLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(48)
            $0.bottom.equalToSuperview().inset(32) // 이게 핵심!
        }
    }

    func setAction() {
        rentButton.addTarget(self, action: #selector(didTapRentButton), for: .touchUpInside)
    }

    @objc func didTapRentButton() {
        delegate?.didTapRentButton()
    }
}

extension HomeBottomSheetView {
    private func makeComment(distance: Double) -> NSAttributedString {
        let fullText = "약 \(distance)km 주행할 수 있어요!"
        let attributedString = NSMutableAttributedString(string: fullText)

        let range = (fullText as NSString).range(of: "\(distance)km")

        attributedString.addAttribute(.foregroundColor, value: UIColor.primary, range: range)
        attributedString.addAttribute(.font, value: UIFont(name: "Pretendard-Medium", size: 15), range: range)

        return attributedString
    }
}
