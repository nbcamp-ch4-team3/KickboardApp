//
//  TabBarController.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/28/25.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

extension TabBarController {
    func configure() {
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "지도", image: UIImage(systemName: "map"), tag: 0)
        
        let registerViewController = ViewController()
        registerViewController.tabBarItem = UITabBarItem(title: "등록", image: UIImage(systemName: "plus"), tag: 1)
        
        let myPageViewController = ViewController()
        myPageViewController.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person.circle"), tag: 2)
        
        viewControllers = [homeViewController, registerViewController, myPageViewController]
    }
}
