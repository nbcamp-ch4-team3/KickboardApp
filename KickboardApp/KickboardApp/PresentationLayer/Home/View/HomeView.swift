//
//  HomeView.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/28/25.
//

import UIKit
import NMapsMap

protocol HomeViewDelegate: AnyObject {
    func didTapMarker()
}

final class HomeView: UIView {
    weak var delegate: HomeViewDelegate?

    private let searchTextField = UITextField()
    private let mapView = NMFMapView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

}

private extension HomeView {
    func configure() {
        setStyle()
        setHierarchy()
        setConstraints()
        setAction()
    }

    func setStyle() {
        searchTextField.do {
            $0.layer.cornerRadius = 10
            $0.layer.shadowColor = UIColor.black2?.cgColor
            $0.layer.shadowOpacity = 0.25
            $0.layer.shadowOffset = CGSize(width: 0, height: 2)
            $0.layer.shadowRadius = 4

            $0.attributedPlaceholder = NSAttributedString(
                string: "제주특별자치도 제주시 첨단로 242",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray3]
            )

            $0.backgroundColor = UIColor.white
            $0.leftViewMode = .always
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))

            var config = UIButton.Configuration.plain()
            config.baseForegroundColor = UIColor.gray1
            config.image = UIImage(systemName: "magnifyingglass")
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12)
            let rightButton = UIButton(configuration: config)
            rightButton.frame = CGRect(x: 0, y: 0, width: 44, height: 48)

            $0.rightViewMode = .always
            $0.rightView = rightButton

            rightButton.addTarget(self, action: #selector(didTapMarker), for: .touchUpInside)
        }
    }

    func setHierarchy() {
        addSubViews(mapView, searchTextField)
    }

    func setConstraints() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        searchTextField.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(28)
            $0.top.equalTo(safeAreaLayoutGuide).offset(24)
            $0.height.equalTo(48)
        }
    }

    func setAction() {

    }

    @objc private func didTapMarker() {
        delegate?.didTapMarker()
    }
}

extension HomeView {
    func moveCamera(to update: NMFCameraUpdate) {
        mapView.moveCamera(update)
    }
}
