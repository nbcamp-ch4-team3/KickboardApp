//
//  MyPageViewController.swift
//  KickboardApp
//
//  Created by 최안용 on 4/28/25.
//

import UIKit

final class MyPageViewController: UIViewController {
    private let rootView = MyPageView()
    private let viewModel: MyPageViewModel
    
    init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        rootView.setListCell(delegate: self)
        setNavigationBar()
        viewModel.delegate = self
        viewModel.action?(.getUserInfo)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.action?(.isUsed)
    }

    private func setNavigationBar() {
        let backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
}

extension MyPageViewController: ListCellViewDelegate {
    func listCellViewDidTap(_ type: ListType) {
        let pageType: PageType?
        
        switch type {
        case .history:
            pageType = .history
        case .kickboard:
            pageType = .kickboard
        case .logout:
            pageType = nil
            
            self.showLogoutAlert {
                LogInManager.shared.deleteLogInInfo()
                
                if let sceneDelegate = UIApplication.shared.connectedScenes
                    .first(where: { $0.activationState == .foregroundActive })?
                    .delegate as? SceneDelegate {
                    sceneDelegate.updateRootViewController()
                }                
            }
        }
        
        if let pageType = pageType {
            let vc = DetailViewController(
                viewModel: .init(
                    pageType: pageType,
                    useCase: DIContainer.shared.makeDetailUseCase()
                )
            )
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MyPageViewController: MyPageViewModelDelegate {
    func didUpdateUser(_ userName: String) {
        rootView.setUserName(userName)
    }
    
    func didUpdateIsUsed(_ isUsed: Bool) {
        rootView.setIsUsed(isUsed)
    }
    
    func didFailWithError(_ error: AppError) {
        self.showErrorAlert(error: error)
    }
}
