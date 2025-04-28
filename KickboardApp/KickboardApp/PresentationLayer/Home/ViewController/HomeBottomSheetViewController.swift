//
//  HomeBottomSheetViewController.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/29/25.
//

import UIKit

class HomeBottomSheetViewController: UIViewController {

    private let homeBottomSheetView = HomeBottomSheetView()

    override func loadView() {
        view = homeBottomSheetView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
