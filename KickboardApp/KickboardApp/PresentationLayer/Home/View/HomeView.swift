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
    func didTapMarkerVisibleButton()
    func didTapReturnButton()
    func didTapSearchButton(with textField: UITextField)
    func didSelectLocal(with local: Local)
}

final class HomeView: UIView {
    weak var delegate: HomeViewDelegate?
    private var searchResultMarker: NMFMarker?
    private var markers: [NMFMarker] = []
    private var areMarkersVisible = true

    private var searchResult = [Local]() {
        didSet {
            searchResultTableView.isHidden = false
            emptyResultLabel.isHidden = !searchResult.isEmpty
        }
    }

    // 대여 전
    private let searchTextField = UITextField()
    private let searchResultTableView = UITableView()
    private let emptyResultLabel = UILabel()
    private let naverMapView = NMFNaverMapView()
    private let markerVisibleButton = UIButton()

    // 대여 후
    private let rentalStatusView = UIView()
    private let rideTimeLabel = UILabel()
    private let fareLabel = UILabel()
    private let batteryView = RemainedBatteryView()
    private let returnButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

    func switchView(isRiding: Bool) {
        searchTextField.isHidden = isRiding
        rentalStatusView.isHidden = !isRiding
        returnButton.isHidden = !isRiding
    }

    func setSearchResult(locals: [Local]) {
        self.searchResult = locals
        searchResultTableView.reloadData()
    }

    func updateUserOverlay(to location: NMGLatLng) {
        naverMapView.mapView.locationOverlay.location = location
        moveCamera(to: location)
    }

    func configureRentalStatusView(kickboard: Kickboard, startTime: String) {
        rideTimeLabel.text = "이용 시작 시간: \(startTime)"
        fareLabel.text = "분당 \(kickboard.brand.pricePerMinute)원"
        batteryView.configure(with: kickboard.battery)
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
        naverMapView.do {
            $0.showLocationButton = true
            $0.mapView.locationOverlay.hidden = false
        }

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

        markerVisibleButton.do {
            $0.setImage(UIImage(systemName: areMarkersVisible ? "eye.slash" : "eye"), for: .normal)
            $0.backgroundColor = UIColor.white
            $0.layer.cornerRadius = 3
            $0.tintColor = .gray2
            $0.layer.shadowColor = UIColor.black2?.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: 2)
            $0.layer.shadowOpacity = 0.15
            $0.layer.shadowRadius = 4
        }

        rentalStatusView.do {
            $0.layer.cornerRadius = 10
            $0.layer.shadowColor = UIColor.black2?.cgColor
            $0.layer.shadowOpacity = 0.25
            $0.layer.shadowOffset = CGSize(width: 0, height: 2)
            $0.layer.shadowRadius = 4

            $0.backgroundColor = .white
        }

        rideTimeLabel.do {
            $0.font = .font(.pretendardSemiBold, ofSize: 17)
            $0.text = "이용 시작 시간: 12:59분"
            $0.textColor = .black
        }

        fareLabel.do {
            $0.font = .font(.pretendardBold, ofSize: 19)
            $0.text = "분당 180원"
            $0.textColor = .black
        }

        batteryView.do {
            $0.configure(with: 64)
        }

        returnButton.do {
            $0.backgroundColor = .primary
            $0.layer.cornerRadius = 10
            $0.setTitle("반납하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .font(.pretendardSemiBold, ofSize: 17)
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
        addSubViews(naverMapView, searchTextField, searchResultTableView, markerVisibleButton, rentalStatusView, returnButton)
        rentalStatusView.addSubViews(rideTimeLabel, fareLabel, batteryView)
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

        markerVisibleButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-92)
            $0.size.equalTo(48)
        }

        rentalStatusView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(safeAreaLayoutGuide).offset(24)
            $0.height.equalTo(100)
        }

        rideTimeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(24)
        }

        fareLabel.snp.makeConstraints {
            $0.leading.equalTo(rideTimeLabel.snp.leading)
            $0.top.equalTo(rideTimeLabel.snp.bottom).offset(12)
        }

        batteryView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(24)
            $0.width.equalTo(20)
        }

        returnButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(markerVisibleButton.snp.centerY)
            $0.width.equalTo(100)
            $0.height.equalTo(40)
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
        markerVisibleButton.addTarget(self, action: #selector(didTapMarkerVisibleButton), for: .touchUpInside)
        returnButton.addTarget(self, action: #selector(didTapReturnButton), for: .touchUpInside)
    }

    @objc func didTapMarkerVisibleButton() {
        self.delegate?.didTapMarkerVisibleButton()
    }

    @objc func didTapReturnButton() {
        self.delegate?.didTapReturnButton()
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

        let cameraUpdate = NMGLatLng(
            lat: local.latitude,
            lng: local.longitude
        )
        moveCamera(to: cameraUpdate)
        delegate?.didSelectLocal(with: local)

        searchResultMarker?.mapView = nil

        let marker = NMFMarker()
        marker.captionText = local.title
        marker.position = cameraUpdate
        marker.mapView = naverMapView.mapView
        searchResultMarker = marker
    }
}

extension HomeView {
    @objc
    private func touchUpInsideSearchButton() {
        delegate?.didTapSearchButton(with: searchTextField)
    }

    func moveCamera(to update: NMGLatLng) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: update, zoomTo: 15)
        cameraUpdate.animation = .easeIn

        naverMapView.mapView.moveCamera(cameraUpdate)
    }

    func toggleMarkersVisibility() {
        areMarkersVisible.toggle()
        markers.forEach {
            $0.mapView = areMarkersVisible ? naverMapView.mapView : nil
        }
        let iconName = areMarkersVisible ? "eye.slash" : "eye"
        markerVisibleButton.setImage(UIImage(systemName: iconName), for: .normal)
    }

    func setMarkersByState(isRented: Bool) {
        areMarkersVisible = !isRented
        markers.forEach { $0.mapView = isRented ? nil : naverMapView.mapView }

        let iconName = isRented ? "eye" : "eye.slash"
        markerVisibleButton.isHidden = isRented
        markerVisibleButton.setImage(UIImage(systemName: iconName), for: .normal)
    }

    func updateKickboardMarkers(with: [Kickboard]) {
        markers.forEach { $0.mapView = nil }
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
}

extension HomeView: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        searchResultTableView.isHidden = true
    }
}

// 로직 구현을 위해 필요한 부수적인 메서드(후에 타 파일로 뺄 수 있는)
extension HomeView {
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
