//
//  InfoCardCell.swift
//  KickboardApp
//
//  Created by 최안용 on 4/29/25.
//

import UIKit

import SnapKit
import Then

final class InfoCardCell: UITableViewCell {
    static let reuseIdentifier = "InfoCardCell"
    private var pageType: PageType?
    private let containerView = UIView()
    private let typeTitleLabel = UILabel()
    private let typeLabel = UILabel()
    private let typeStackView = UIStackView()
    private let dateTitleLabel = UILabel()
    private let dateLabel = UILabel()
    private let dateStackView = UIStackView()
    private let firstInfoTitleLabel = UILabel()
    private let firstInfoLabel = UILabel()
    private let firstInfoStackView = UIStackView()
    private let secondInfoTitleLabel = UILabel()
    private let secondInfoLabel = UILabel()
    private let secondInfoStackView = UIStackView()
    private let iconImageView = UIImageView()
    private let modelLabel = UILabel()
    private let modelStackView = UIStackView()
    private let infoStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setShadow()
    }
}

private extension InfoCardCell {
    func configure() {
        setStyle()
        setHierarchy()
        setConstraints()
        setAction()
    }
    
    func setStyle() {
        containerView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 10
        }
        
        typeTitleLabel.do {
            $0.text = "브랜드 : "
            $0.font = .font(.pretendardRegular, ofSize: 15)
            $0.textColor = .black
            $0.numberOfLines = 1
        }
        
        typeLabel.do {
            $0.font = .font(.pretendardRegular, ofSize: 15)
            $0.textColor = .black
            $0.numberOfLines = 1
        }
        
        typeStackView.do {
            $0.axis = .horizontal
            $0.spacing = 3
        }
        
        dateTitleLabel.do {
            $0.text = "날짜 : "
            $0.font = .font(.pretendardRegular, ofSize: 15)
            $0.textColor = .black
            $0.numberOfLines = 1
        }
        
        dateLabel.do {
            $0.font = .font(.pretendardRegular, ofSize: 15)
            $0.textColor = .black
            $0.numberOfLines = 1
        }
        
        dateStackView.do {
            $0.axis = .horizontal
            $0.spacing = 3
        }
        
        firstInfoTitleLabel.do {
            $0.text = pageType?.firstInfoTitle
            $0.font = .font(.pretendardRegular, ofSize: 15)
            $0.textColor = .black
            $0.numberOfLines = 0
        }
        
        firstInfoLabel.do {
            $0.font = .font(.pretendardRegular, ofSize: 15)
            $0.textColor = .black
            $0.numberOfLines = 1
        }
        
        firstInfoStackView.do {
            $0.axis = .horizontal
            $0.spacing = 3
        }
        
        secondInfoTitleLabel.do {
            $0.text = pageType?.secondInfoTitle
            $0.font = .font(.pretendardRegular, ofSize: 15)
            $0.textColor = .black
            $0.numberOfLines = 1
        }
        
        secondInfoLabel.do {
            $0.font = .font(.pretendardMedium, ofSize: 15)
            $0.textColor = .black
            $0.numberOfLines = 1
        }
        
        secondInfoStackView.do {
            $0.axis = .horizontal
            $0.spacing = 3
        }
        
        infoStackView.do {
            $0.axis = .vertical
            $0.spacing = 4
            $0.alignment = .leading
        }
        
        iconImageView.do {
            $0.image = .logo
        }
        
        modelLabel.do {
            $0.font = .font(.pretendardBold, ofSize: 13)
            $0.textColor = .primary
            $0.numberOfLines = 1
        }
        
        modelStackView.do {
            $0.axis = .horizontal
            $0.spacing = 7
            $0.alignment = .center
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.primary?.cgColor
            $0.directionalLayoutMargins = .init(top: 3, leading: 8, bottom: 2, trailing: 8)
            $0.isLayoutMarginsRelativeArrangement = true
        }
    }
    
    func setHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubViews(infoStackView, modelStackView)
        infoStackView.addArrangedSubviews(
            typeStackView,
            dateStackView,
            firstInfoStackView,
            secondInfoStackView
        )
        typeStackView.addArrangedSubviews(typeTitleLabel, typeLabel)
        dateStackView.addArrangedSubviews(dateTitleLabel, dateLabel)
        firstInfoStackView.addArrangedSubviews(firstInfoTitleLabel, firstInfoLabel)
        secondInfoStackView.addArrangedSubviews(secondInfoTitleLabel, secondInfoLabel)
        modelStackView.addArrangedSubviews(iconImageView, modelLabel)
    }
    
    func setConstraints() {
        infoStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.verticalEdges.equalToSuperview().inset(8)
        }
        
        modelStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(9)
            $0.leading.greaterThanOrEqualTo(infoStackView.snp.trailing)
            $0.trailing.equalToSuperview().inset(9)
        }
        
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(20)
        }

        typeStackView.snp.makeConstraints {
            $0.height.equalTo(24)
        }
        
        dateStackView.snp.makeConstraints {
            $0.height.equalTo(24)
        }
        
        firstInfoStackView.snp.makeConstraints {
            $0.height.equalTo(24)
        }
        
        secondInfoStackView.snp.makeConstraints {
            $0.height.equalTo(24)
        }
        
        containerView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.verticalEdges.equalToSuperview().inset(12)
        }
    }
    
    func setAction() {
        
    }
    
    func setShadow() {
        containerView.layer.shadowRadius = 3
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowColor = UIColor.black.cgColor

        containerView.layer.shadowPath = UIBezierPath(
            roundedRect: containerView.bounds,
            cornerRadius: containerView.layer.cornerRadius
        ).cgPath
    }
}

extension InfoCardCell {
    func setType(_ type: PageType) {
        self.pageType = type
        firstInfoTitleLabel.text = type.firstInfoTitle
        secondInfoTitleLabel.text = type.secondInfoTitle
    }
    
    func setHistory(_ history: RideHistory) {
        typeLabel.text = history.kickboard.brand.title

        dateLabel.text = history.endTime.toShortDateString()
        firstInfoLabel.text = "\(history.startTime.toTimeString()) ~ \(history.endTime.toTimeString())"
        secondInfoLabel.text = history.price.toPriceString()
        modelLabel.text = String(history.kickboard.id.uuidString.prefix(8))
    }
    
    func setRegisteredKickboard(_ kickboard: Kickboard) {
        typeLabel.text = kickboard.brand.title
        dateLabel.text = kickboard.date.toShortDateString()

        let manager = AddressManager()
        Task {
            let address = try? await manager.fetchAddress(lat: kickboard.latitude, lng: kickboard.longitude)
            await MainActor.run {
                firstInfoLabel.text = address
            }
        }

        modelLabel.text = String(kickboard.id.uuidString.prefix(8))
        secondInfoTitleLabel.isHidden = true
        secondInfoLabel.isHidden = true

//        typeLabel.text = useInfo.type
//        dateLabel.text = useInfo.date
//        firstInfoLabel.text = useInfo.address
//        modelLabel.text = useInfo.model
//        secondInfoTitleLabel.isHidden = true
//        secondInfoLabel.isHidden = true
    }
 }
