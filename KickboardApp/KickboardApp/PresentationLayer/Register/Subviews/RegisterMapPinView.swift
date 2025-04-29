//
//  RegisterMapPinView.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import UIKit

final class RegisterMapPinView: UIView {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let tailView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

    private func addTailShape() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 15, y: 0))
        path.addLine(to: CGPoint(x: 7.5, y: 15))
        path.close()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.black2?.cgColor

        tailView.layer.insertSublayer(shapeLayer, at: 0)
    }
}
private extension RegisterMapPinView {

    func configure() {
        setLayout()
        setHierarchy()
        setConstraints()
    }

    func setLayout() {
        containerView.do {
            $0.backgroundColor = .black2
            $0.layer.cornerRadius = 8
        }

        titleLabel.do {
            $0.text = "등록 위치"
            $0.textColor = .primary
            $0.font = .font(.pretendardBold, ofSize: 14)
            $0.textAlignment = .center
        }

        subTitleLabel.do {
            $0.text = "킥보드의 위치를 설정해주세요"
            $0.textColor = .white
            $0.font = .font(.pretendardRegular, ofSize: 12)
            $0.textAlignment = .center
        }
    }

    func setHierarchy() {
        self.addSubViews(containerView, tailView)
        containerView.addSubViews(titleLabel, subTitleLabel)
    }

    func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.directionalHorizontalEdges.equalToSuperview().inset(12)
        }

        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.directionalHorizontalEdges.bottom.equalToSuperview().inset(12)
        }

        tailView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom)
            make.width.equalTo(15)
            make.height.equalTo(15)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        addTailShape()
    }
}

