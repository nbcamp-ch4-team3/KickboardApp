//
//  EmptyView.swift
//  KickboardApp
//
//  Created by 최안용 on 5/1/25.
//

import UIKit

import SnapKit
import Then

final class EmptyView: UIView {
    private let imageView = UIImageView()
    private let textLabel = UILabel()
    private let pageType: PageType
    
    init(pageType: PageType) {
        self.pageType = pageType
        super.init(frame: .zero)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EmptyView {
    func configure() {
        setStyle()
        setHierarchy()
        setConstraints()
    }
    
    func setStyle() {
        imageView.do {
            $0.image = .emptyLogo
        }
        
        textLabel.do {
            $0.text = pageType.emptyMessage
            $0.font = .font(.pretendardBold, ofSize: 19)
            $0.textColor = .black
        }
    }
    
    func setHierarchy() {
        addSubViews(imageView, textLabel)
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(218)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
}
