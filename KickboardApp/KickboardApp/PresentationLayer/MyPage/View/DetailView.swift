//
//  DetailView.swift
//  KickboardApp
//
//  Created by 최안용 on 4/29/25.
//

import UIKit

final class DetailView: UIView {
    private let tableView = UITableView()
    private let data: [PageType] = [.history, .history, .history, .history]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
        tableView.register(InfoCardCell.self, forCellReuseIdentifier: InfoCardCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
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

extension DetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: InfoCardCell.reuseIdentifier,
            for: indexPath
        ) as? InfoCardCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.setType(data[indexPath.row])
        return cell
    }
    
    
}

extension DetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147
    }
    
    
}
