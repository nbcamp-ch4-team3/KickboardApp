//
//  MyPageViewController.swift
//  KickboardApp
//
//  Created by 최안용 on 4/28/25.
//

import UIKit

final class MyPageViewController: UIViewController {
    private let rootView = MyPageView()
    
    override func viewDidLoad() {
        view = rootView
        rootView.hitoryCell.delegate = self
        rootView.kickboardCell.delegate = self
        rootView.logoutCell.delegate = self
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        let backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
}

extension MyPageViewController: ListCellViewDelegate {
    func listCellViewDidTap(_ type: ListType) {
        print(type)
        
        
        let pageType: PageType
        
        switch type {
        case .history:
            pageType = .history
        case .kickboard:
            pageType = .kickboard
        case .logout:
            return
        }
        
        let vc = DetailViewController(pageType)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
