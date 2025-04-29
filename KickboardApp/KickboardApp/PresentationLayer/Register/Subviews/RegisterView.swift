//
//  RegisterView.swift
//  KickboardApp
//
//  Created by 이수현 on 4/28/25.
//

import UIKit

final class RegisterView: UIView {

    private let titleView = RegisterTitleView()
    private let mapView = UIView()

    private let settingView = KickboardSettingView()


    init() {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setKickboardSettingViewDelegate(_ delegate: KickboardSettingViewDelegate) {
        settingView.delegate = delegate
    }
}

private extension RegisterView {
    func configure() {
        setHierarchy()
        setStyle()
        setConstraints()
    }

    func setHierarchy() {
        addSubViews(titleView, mapView, settingView)
    }

    func setStyle() {
        self.backgroundColor = .white
        mapView.do {
            $0.backgroundColor = .red
        }

        settingView.do {
            $0.layer.cornerRadius = 15
            $0.layer.shadowColor = UIColor.black2?.cgColor
            $0.layer.shadowOpacity = 0.25
            $0.layer.shadowRadius = 6
            $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        }
    }

    func setConstraints() {
        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.directionalHorizontalEdges.equalToSuperview()
        }

        mapView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(12)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.directionalHorizontalEdges.equalToSuperview()
        }

        settingView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.directionalHorizontalEdges.equalToSuperview()
        }
    }
}
