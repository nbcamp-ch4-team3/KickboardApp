//
//  RegisterView.swift
//  KickboardApp
//
//  Created by 이수현 on 4/28/25.
//

import UIKit
import NMapsMap

final class RegisterView: UIView {

    private let titleView = RegisterTitleView()
    private let mapView = NMFMapView()
    private let mapPinView = RegisterMapPinView()
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

    func setDataSource(brands: [Brand]) {
        settingView.setDataSource(brands: brands)
    }

    func moveCamera(to update: NMGLatLng) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: update, zoomTo: 15)
        cameraUpdate.animation = .easeIn

        mapView.moveCamera(cameraUpdate)
    }
}

private extension RegisterView {
    func configure() {
        setHierarchy()
        setStyle()
        setConstraints()
        setProtocol()
    }

    func setHierarchy() {
        addSubViews(titleView, mapView, mapPinView, settingView)
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
            make.bottom.equalTo(settingView.snp.top)
            make.directionalHorizontalEdges.equalToSuperview()
        }

        mapPinView.snp.makeConstraints { make in
            make.center.equalTo(mapView)
        }

        settingView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.directionalHorizontalEdges.equalToSuperview()
        }
    }

    func setProtocol() {
        mapView.addCameraDelegate(delegate: self)
    }
}

extension RegisterView: NMFMapViewCameraDelegate {
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        let location = mapView.cameraPosition.target
        settingView.configure(location: location)
    }
}
