//
//  HomeView.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/28/25.
//

import UIKit
import NMapsMap

protocol HomeViewDelegate: AnyObject {
    func didTapMarker(with kickboard: Kickboard)
    func didTapSearchButton(with textField: UITextField)
    func didSelectLocal(with local: Local)
}

final class HomeView: UIView {
    weak var delegate: HomeViewDelegate?
    private var markers: [NMFMarker] = []
    private var searchResult = [Local]() {
        didSet {
            searchResultTableView.isHidden = false
            emptyResultLabel.isHidden = !searchResult.isEmpty
        }
    }

    private let searchTextField = UITextField()
    private let searchResultTableView = UITableView()
    private let emptyResultLabel = UILabel()
    private let naverMapView = NMFNaverMapView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

    func setSearchResult(locals: [Local]) {
        self.searchResult = locals
        searchResultTableView.reloadData()
    }
}

private extension HomeView {
    func configure() {
        setStyle()
        setHierarchy()
        setConstraints()
        setAction()
        setProtocol()
    }

    func setStyle() {
        naverMapView.showLocationButton = true

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
            rightButton.addTarget(
                self,
                action: #selector(touchUpInsideSearchButton),
                for: .touchUpInside
            )
            $0.rightViewMode = .always
            $0.rightView = rightButton
        }

        searchResultTableView.do {
            $0.register(
                SearchResultTableViewCell.self,
                forCellReuseIdentifier: SearchResultTableViewCell.id
            )
            $0.layer.cornerRadius = 10
            $0.isHidden = true
        }

        emptyResultLabel.do {
            $0.text = "검색 결과가 없습니다."
            $0.textColor = .gray2
            $0.font = .font(.pretendardBold, ofSize: 16)
            $0.textAlignment = .center
            $0.isHidden = true
        }
    }

    func setHierarchy() {
        addSubViews(naverMapView, searchTextField, searchResultTableView)
        searchResultTableView.backgroundView = emptyResultLabel
    }

    func setConstraints() {
        naverMapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        searchTextField.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(28)
            $0.top.equalTo(safeAreaLayoutGuide).offset(24)
            $0.height.equalTo(48)
        }

        searchResultTableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.directionalHorizontalEdges.equalTo(searchTextField)
            make.height.equalTo(200)
        }

        emptyResultLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func setAction() {

    }

    func setProtocol() {
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
        naverMapView.mapView.touchDelegate = self
    }
}

extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultTableViewCell.id
        ) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: searchResult[indexPath.row])
        return cell
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let local = searchResult[indexPath.row]
        searchTextField.text = local.title
        searchResultTableView.isHidden = true
        delegate?.didSelectLocal(with: local)
    }
}

extension HomeView {
    @objc
    private func touchUpInsideSearchButton() {
        delegate?.didTapSearchButton(with: searchTextField)
    }

    func moveCamera(to update: NMGLatLng) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: update)
        cameraUpdate.animation = .easeIn

        let locationOverlay = naverMapView.mapView.locationOverlay
        locationOverlay.location = update
        locationOverlay.hidden = false
        
        naverMapView.mapView.moveCamera(cameraUpdate)
    }

    func updateKickboardMarkers(with: [Kickboard]) {
        markers.removeAll()

        with.forEach { kickboard in
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: kickboard.latitude, lng: kickboard.longitude)
            marker.mapView = naverMapView.mapView
            marker.iconImage = NMF_MARKER_IMAGE_BLACK
            marker.iconTintColor = colorByBrand(by: kickboard.brand.title)
            marker.width = 25
            marker.height = 35
            marker.touchHandler = { [weak self] (overlay: NMFOverlay) -> Bool in
                guard let self else { return false }
                
                self.delegate?.didTapMarker(with: kickboard)

                return true
            }
            markers.append(marker)
        }
    }

    func colorByBrand(by brandTitle: String) -> UIColor {
        switch brandTitle {
        case "킥":
            return UIColor(hex: "00C2AC") ?? .cyan
        case "빔":
            return UIColor(hex: "7247FE") ?? .purple
        case "씽씽":
            return UIColor(hex: "FFD937") ?? .yellow
        default:
            return UIColor.green
        }
    }
}

extension HomeView: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        searchResultTableView.isHidden = true
    }
}
