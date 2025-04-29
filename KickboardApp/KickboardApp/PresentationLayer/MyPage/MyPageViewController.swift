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
    }
}
