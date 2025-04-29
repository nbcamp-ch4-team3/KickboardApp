//
//  RemainedBatteryView.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/29/25.
//

import UIKit

final class RemainedBatteryView: UIView {

    private let stackView = UIStackView()
    private let remainedValueLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

    func configure(with battery: Int) {
        updateRemainedBattery(remained: battery)
    }

}

private extension RemainedBatteryView {
    func configure() {
        setStyle()
        setHierarchy()
        setConstraints()
        setAction()
    }

    func setStyle() {
        setStackView()

        remainedValueLabel.font = UIFont(name: "Pretendard-SemiBold", size: 10)
    }

    func setHierarchy() {
        addSubViews(stackView ,remainedValueLabel)
    }

    func setConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }

        remainedValueLabel.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
    }

    func setAction() {

    }

    func setStackView() {
        stackView.axis = .vertical
        stackView.spacing = 2

        for i in 0..<5 {
            let unitView = UIView()
            unitView.backgroundColor = .gray3
            unitView.layer.cornerRadius = 2

            unitView.snp.makeConstraints {
                $0.width.equalTo(16)
                $0.height.equalTo(8)
            }

            stackView.addArrangedSubview(unitView)
        }
    }

    func updateRemainedBattery(remained: Int) {
        remainedValueLabel.text = String(remained) + "%"
        remainedValueLabel.textColor = remained > 0 ? .primary : .gray3
        let filledCount = remained / 20

        for i in 0..<5 {
            stackView.arrangedSubviews[4 - i].backgroundColor = i < filledCount ? .primary : .gray3
        }
    }
}

