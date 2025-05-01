//
//  DetailView.swift
//  KickboardApp
//
//  Created by 최안용 on 4/29/25.
//

import UIKit

final class DetailView: UIView {
    private let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
        tableView.register(InfoCardCell.self, forCellReuseIdentifier: InfoCardCell.reuseIdentifier)
    }
    
    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}

private extension DetailView {
    func configure() {
        setStyle()
        setHierarchy()
        setConstraints()
        setAction()
    }
    
    func setStyle() {
        backgroundColor = .white
        
        tableView.do {
            $0.separatorStyle = .none
        }
    }
    
    func setHierarchy() {
        addSubview(tableView)
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setAction() {
        
    }
}

extension DetailView {
    func tableViewConfigure(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
    
    func tableViewReloadData() {
        tableView.reloadData()
    }
    
    func updateBackgroundView(_ isEmpty: Bool) {
        if isEmpty {
            let label = UILabel()
            
            label.do {
                $0.text = "검색 결과 없음"
                $0.textColor = .systemGray
                $0.font = .systemFont(ofSize: 16, weight: .medium)
                $0.textAlignment = .center
            }
            tableView.backgroundView = label
        } else {
            tableView.backgroundView = nil
        }
    }
}
