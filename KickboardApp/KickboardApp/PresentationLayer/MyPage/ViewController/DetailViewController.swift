//
//  DetailViewController.swift
//  KickboardApp
//
//  Created by 최안용 on 4/29/25.
//

import UIKit

final class DetailViewController: UIViewController {
    private let rootView = DetailView()
    private let viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view = rootView
        viewModel.delegate = self
        rootView.tableViewConfigure(delegate: self, dataSource: self)
        setNavigationBar()
        viewModel.action?(.getInfo)
    }
    
    private func setNavigationBar() {
        navigationItem.title = viewModel.pageType.navigationTitle
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.3
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navigationController?.navigationBar.layer.shadowRadius = 2
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.pageType {
        case .history:
            viewModel.historys.count
        case .kickboard:
            viewModel.registeredKickboards.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: InfoCardCell.reuseIdentifier,
            for: indexPath
        ) as? InfoCardCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        switch viewModel.pageType {
        case .history:
            cell.setType(.history)
            cell.setHistory(viewModel.historys[indexPath.row])
        case .kickboard:
            cell.setType(.kickboard)
            cell.setRegisteredKickboard(viewModel.registeredKickboards[indexPath.row])
        }
        
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func getInfo() {
        switch viewModel.pageType {
        case .history:
            if viewModel.historys.isEmpty {
                rootView.updateBackgroundView(true, .history)
            } else {
                rootView.updateBackgroundView(false, .history)
            }
        case .kickboard:
            if viewModel.registeredKickboards.isEmpty {
                rootView.updateBackgroundView(true, .kickboard)
            } else {
                rootView.updateBackgroundView(false, .kickboard)
            }
        }
        rootView.tableViewReloadData()
    }

    func didFailWithError(_ error: AppError) {
        self.showErrorAlert(error: error)
    }
}
