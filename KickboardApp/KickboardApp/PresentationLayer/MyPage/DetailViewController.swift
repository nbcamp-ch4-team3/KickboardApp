//
//  DetailViewController.swift
//  KickboardApp
//
//  Created by 최안용 on 4/29/25.
//

import UIKit

final class DetailViewController: UIViewController {
    private let rootView = DetailView()
    private let type: PageType
    
    init(_ type: PageType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view = rootView
        
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.title = type.navigationTitle
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
