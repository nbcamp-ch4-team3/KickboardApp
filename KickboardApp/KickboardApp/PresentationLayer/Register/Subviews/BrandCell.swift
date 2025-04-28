//
//  BrandCell.swift
//  KickboardApp
//
//  Created by 이수현 on 4/28/25.
//

import UIKit

final class BrandCell: UICollectionViewCell {
    static let id = "BrandCell"

    override var isSelected: Bool {
        didSet {
            updateBorder()
        }
    }

    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with data: Brand) {
        imageView.image = UIImage(named: data.imageName)
    }

    private func updateBorder() {
        imageView.layer.borderColor = isSelected
        ? UIColor.primary?.cgColor
        : UIColor.gray3?.cgColor
    }
}

private extension BrandCell {
    func configure() {
        setHierarchy()
        setStyle()
        setConstraints()
    }

    func setHierarchy() {
        self.contentView.addSubview(imageView)
    }

    func setStyle() {
        self.backgroundColor = .white

        imageView.do {
            $0.layer.cornerRadius = 5
            $0.layer.borderColor = UIColor.gray3?.cgColor
            $0.layer.borderWidth = 3
            $0.clipsToBounds = true
        }
    }

    func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
}
