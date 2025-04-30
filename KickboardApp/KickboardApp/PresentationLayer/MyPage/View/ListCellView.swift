//
//  ListCellView.swift
//  KickboardApp
//
//  Created by 최안용 on 4/29/25.
//

import UIKit

import SnapKit
import Then

protocol ListCellViewDelegate: AnyObject {
    func listCellViewDidTap(_ type: ListType)
}

final class ListCellView: UIView {
    private let listType: ListType
    private let leadingIconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let trailingIconImageView = UIImageView()
    
    weak var delegate: ListCellViewDelegate?
    
    init(type: ListType) {
        self.listType = type
        super.init(frame: .zero)
        
        configure()
    }
    
    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}

private extension ListCellView {
    func configure() {
        setStyle()
        setHierarchy()
        setConstraints()
        setAction()
    }
    
    func setStyle() {
        leadingIconImageView.do {
            $0.image = UIImage(named: listType.leadingIconName)
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
        
        titleLabel.do {
            $0.text = listType.rawValue
            $0.font = .font(.pretendardMedium, ofSize: 15)
            $0.textColor = listType.isRedColor ? .customRed : .black
        }
        
        trailingIconImageView.do {
            $0.image = UIImage(imageLiteralResourceName: listType.trailingIconName)
            $0.isHidden = listType.isTrailingIcon
        }
    }
    
    func setHierarchy() {
        addSubViews(leadingIconImageView, titleLabel, trailingIconImageView)
    }
    
    func setConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(47)
        }
        
        leadingIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(listType.leadingSpacing)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(listType.leadingIconWidth)
            $0.height.equalTo(listType.leadingIconHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(leadingIconImageView.snp.trailing).offset(listType.titleLeadingSpacing)
            $0.centerY.equalToSuperview()
        }
        
        trailingIconImageView.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(26)
        }
    }
    
    func setAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.addGestureRecognizer(tapGesture)
    }
        
    @objc
    func didTapView() {
        delegate?.listCellViewDidTap(listType)
    }
}
