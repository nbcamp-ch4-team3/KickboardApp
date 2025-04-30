//
//  SearchResultTableViewCell.swift
//  KickboardApp
//
//  Created by 이수현 on 4/30/25.
//

import UIKit

final class SearchResultTableViewCell: UITableViewCell {
    static let id = "SearchResultTableViewCell"

    private let titleLabel = UILabel()
    private let addressLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = nil
        addressLabel.text = nil
    }

    func configure(with local: Local) {
        titleLabel.text = local.title
        addressLabel.text = local.roadAddress
    }
}

private extension SearchResultTableViewCell {

    func configure() {
        setHierarchy()
        setLayout()
        setConstraints()
    }


    func setHierarchy() {
        self.addSubViews(titleLabel, addressLabel)
    }

    func setLayout() {
        self.backgroundColor = .white

        titleLabel.do {
            $0.font = .font(.pretendardBold, ofSize: 16)
            $0.textColor = .black
            $0.numberOfLines = 1
        }

        addressLabel.do {
            $0.font = .font(.pretendardBold, ofSize: 12)
            $0.textColor = .gray2
            $0.numberOfLines = 1
        }
    }

    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview().inset(8)
        }

        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.directionalHorizontalEdges.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(8)
        }
    }
}

