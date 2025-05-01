//
//  MyPageView.swift
//  KickboardApp
//
//  Created by 최안용 on 4/28/25.
//

import UIKit

import SnapKit
import Then

final class MyPageView: UIView {
    private let backgroundColorView = UIView()
    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()
    private let useTitleLabel = UILabel()
    private let useLabel = UILabel()
    private let userInfoStackView = UIStackView()
    private let useStackView = UIStackView()
    private let containerView = UIView()
    private let separatorView = UIView()
    private let cellSeparatorView = UIView()
    private let myPageTitleLabel = UILabel()
    private let historyCell = ListCellView(type: .history)
    private let kickboardCell = ListCellView(type: .kickboard)
    private let logoutCell = ListCellView(type: .logout)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}

private extension MyPageView {
    func configure() {
        setStyle()
        setHierarchy()
        setConstraints()
        setAction()
    }
    
    func setStyle() {
        backgroundColor = .white
        
        backgroundColorView.do {
            $0.backgroundColor = UIColor.secondary
        }
        
        containerView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
        }
        
        iconImageView.do {
            $0.image = .logo            
        }
        
        nameLabel.do {
            $0.font = .font(.pretendardBold, ofSize: 18)
            $0.textColor = .primary
        }
        
        useTitleLabel.do {
            $0.text = "이용 여부: "
            $0.font = .font(.pretendardRegular, ofSize: 15)
            $0.textColor = .black
        }
        
        useLabel.do {
            $0.font = .font(.pretendardRegular, ofSize: 15)
            $0.textColor = .black
        }
        
        userInfoStackView.do {
            $0.axis = .vertical
            $0.spacing = 8
            $0.alignment = .leading
        }
        
        useStackView.do {
            $0.axis = .horizontal
            $0.spacing = 4
            $0.alignment = .center
        }
        
        separatorView.do {
            $0.backgroundColor = .gray3
        }
        
        myPageTitleLabel.do {
            $0.text = "마이페이지"
            $0.font = .font(.pretendardSemiBold, ofSize: 20)
            $0.textColor = .primary
        }
        
        cellSeparatorView.do {
            $0.backgroundColor = .gray3
        }
    }
    
    func setHierarchy() {
        addSubViews(
            backgroundColorView,
            containerView,
            myPageTitleLabel,
            historyCell,
            kickboardCell,
            cellSeparatorView,
            logoutCell
        )
        containerView.addSubViews(iconImageView, userInfoStackView, separatorView)
        userInfoStackView.addArrangedSubviews(nameLabel, useStackView)
        useStackView.addArrangedSubviews(useTitleLabel, useLabel)
    }
    
    func setConstraints() {
        backgroundColorView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(215)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(backgroundColorView.snp.top).offset(87)
            $0.directionalHorizontalEdges.equalToSuperview().inset(32)
            $0.bottom.equalTo(backgroundColorView.snp.bottom)
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.size.equalTo(80)
        }
        
        userInfoStackView.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(iconImageView.snp.centerY)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview().inset(23)
            $0.height.equalTo(2)
        }
        
        myPageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundColorView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
        
        historyCell.snp.makeConstraints {
            $0.top.equalTo(myPageTitleLabel.snp.bottom).offset(10)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        kickboardCell.snp.makeConstraints {
            $0.top.equalTo(historyCell.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        cellSeparatorView.snp.makeConstraints {
            $0.top.equalTo(kickboardCell.snp.bottom).offset(6)
            $0.directionalHorizontalEdges.equalToSuperview().inset(8)
            $0.height.equalTo(2)
        }
        
        logoutCell.snp.makeConstraints {
            $0.top.equalTo(cellSeparatorView.snp.bottom).offset(8)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
    }
    
    func setAction() {
        
    }
}

extension MyPageView {
    func setUserName(_ userName: String) {
        nameLabel.text = userName
    }
    
    func setIsUsed(_ isUsed: Bool) {
        useLabel.text = isUsed ? "이용중" : "미사용"
    }
    
    func setListCell(delegate: ListCellViewDelegate) {
        historyCell.delegate = delegate
        kickboardCell.delegate = delegate
        logoutCell.delegate = delegate
    }
}
