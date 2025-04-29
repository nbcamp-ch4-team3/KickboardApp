//
//  KickboardSettingView.swift
//  KickboardApp
//
//  Created by 이수현 on 4/28/25.
//

import UIKit
import Then
import SnapKit
import NMapsMap

protocol KickboardSettingViewDelegate: AnyObject {
    func didTapRegisterButton(latitude: Double, longitude: Double, brand: Brand, battery: Int)
}

final class KickboardSettingView: UIView {
    private let dataSource = Brand.mockData()
    private var selectedBrand: Brand?
    private var selectedBatteryUnit: Int = 100

    weak var delegate: KickboardSettingViewDelegate?

    private let batteryUnit = (0...100).filter{ $0 % 5 == 0 }.reversed().map{"\($0)%"}
    private let locationStackView = UIStackView()

    private let latitudeStackView = UIStackView()
    private let latitudeLabel = UILabel()
    private let latitudeValueLabel = UILabel()

    private let longitudeStackView = UIStackView()
    private let longitudeLabel = UILabel()
    private let longitudeValueLabel = UILabel()

    private let brandStackView = UIStackView()
    private let brandLabel = UILabel()
    private let brandCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then(
            { layout in
                layout.itemSize = CGSize(width: 60, height: 60)
                layout.scrollDirection = .horizontal
            }
        )
    )

    private let batteryStackView = UIStackView()
    private let batteryLabel = UILabel()
    private let batteryPickerView = UIPickerView()
    private let registerButton = UIButton()


    init() {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(location: NMGLatLng) {
        latitudeValueLabel.text = location.lat.formatted(toDecimalDigits: 4)
        longitudeValueLabel.text = location.lng.formatted(toDecimalDigits: 4)
    }
}

private extension KickboardSettingView {
    func configure() {
        setHierarchy() // 뷰 계층 구조 (addSubview())
        setStyle() // 컴포넌트 스타일 정의
        setConstraints() // 제약조건
        setAction()
    }

    func setHierarchy() {
        self.addSubViews(
            locationStackView,
            brandStackView,
            batteryStackView,
            registerButton
        )

        locationStackView.addArrangedSubviews(latitudeStackView, longitudeStackView)
        latitudeStackView.addArrangedSubviews(latitudeLabel, latitudeValueLabel)
        longitudeStackView.addArrangedSubviews(longitudeLabel, longitudeValueLabel)

        brandStackView.addArrangedSubviews(brandLabel, brandCollectionView)
        batteryStackView.addArrangedSubviews(batteryLabel, batteryPickerView)
    }

    func setStyle() {
        self.backgroundColor = .white
        //MARK: Location StackView
        locationStackView.do {
            $0.axis = .horizontal
            $0.spacing = 20
            $0.distribution = .fillEqually
        }

        //MARK: latitudeStackView
        latitudeStackView.do {
            $0.axis = .horizontal
            $0.spacing = 12
        }

        latitudeLabel.do {
            $0.text = "위도"
            $0.textColor = .black
            $0.font = .font(.pretendardMedium, ofSize: 16)
        }

        latitudeValueLabel.do {
            $0.backgroundColor = .gray4
            $0.textAlignment = .center
            $0.text = "위도 값"
            $0.textColor = .black2
            $0.font = .font(.pretendardMedium, ofSize: 14)
        }

        //MARK: longitudeStackView
        longitudeStackView.do {
            $0.axis = .horizontal
            $0.spacing = 12
        }

        longitudeLabel.do {
            $0.text = "경도"
            $0.textColor = .black
            $0.font = .font(.pretendardMedium, ofSize: 16)
        }

        longitudeValueLabel.do {
            $0.backgroundColor = .gray4
            $0.textAlignment = .center
            $0.text = "경도 값"
            $0.textColor = .black2
            $0.font = .font(.pretendardMedium, ofSize: 14)
        }

        //MARK: brandStackView
        brandStackView.do {
            $0.axis = .horizontal
            $0.spacing = 30
        }

        brandLabel.do {
            $0.text = "브랜드"
            $0.textColor = .black
            $0.font = .font(.pretendardMedium, ofSize: 19)
        }

        brandCollectionView.do {
            $0.backgroundColor = .white
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.delegate = self
            $0.dataSource = self
            $0.register(BrandCell.self, forCellWithReuseIdentifier: BrandCell.id)
        }

        //MARK: batteryStackView
        batteryStackView.do {
            $0.axis = .horizontal
            $0.spacing = 30
            $0.distribution = .fillEqually

        }

        batteryLabel.do {
            $0.text = "배터리 잔량"
            $0.textColor = .black
            $0.font = .font(.pretendardMedium, ofSize: 19)
        }

        batteryPickerView.do {
            $0.delegate = self
            $0.dataSource = self
        }

        //MARK: registerButton
        registerButton.do {
            $0.setTitle("등록하기", for: .normal)
            $0.titleLabel?.font = .font(.pretendardSemiBold, ofSize: 16)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .primary
            $0.layer.cornerRadius = 10
        }
    }

    func setConstraints() {
        locationStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.directionalHorizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(30)
        }

        latitudeLabel.snp.makeConstraints { make in
            make.width.equalTo(30)
        }

        longitudeLabel.snp.makeConstraints { make in
            make.width.equalTo(30)
        }

        brandStackView.snp.makeConstraints { make in
            make.top.equalTo(locationStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(28)
            make.trailing.equalToSuperview()
            make.height.equalTo(60)
        }

        batteryStackView.snp.makeConstraints { make in
            make.top.equalTo(brandStackView.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(40)
        }

        registerButton.snp.makeConstraints { make in
            make.top.equalTo(batteryStackView.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(20)
            make.directionalHorizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(44)
        }
    }

    func setAction() {
        registerButton.addTarget(self, action: #selector(touchUpInsideRegisterButton), for: .touchUpInside)
    }

    @objc
    func touchUpInsideRegisterButton(){
        guard let latitudeString = latitudeValueLabel.text,
              let latitude = Double(latitudeString),
              let longitudeString = longitudeValueLabel.text,
              let longitude = Double(longitudeString),
              let brand = selectedBrand
        else {
            return
        }

        delegate?.didTapRegisterButton(
            latitude: latitude, longitude: longitude, brand: brand, battery: selectedBatteryUnit
        )
    }
}

// MARK: UICollectionViewDataSource
extension KickboardSettingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count * 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCell.id, for: indexPath) as? BrandCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: dataSource[indexPath.item % dataSource.count])
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension KickboardSettingView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedBrand = dataSource[indexPath.item % dataSource.count]
    }
}

// MARK: UIPickerViewDataSource
extension KickboardSettingView: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return batteryUnit.count
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        35
    }
}

// MARK: UIPickerViewDelegate
extension KickboardSettingView: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return batteryUnit[row]
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = batteryUnit[row]
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black, // 텍스트 색
            .font: UIFont.font(.pretendardBlack, ofSize: 12)// 폰트
        ]
        return NSAttributedString(string: title, attributes: attributes)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let batteryString = batteryUnit[row].split(separator: "%").first,
              let battery = Int(batteryString)
        else {
            return
        }
        self.selectedBatteryUnit = battery
    }
}
