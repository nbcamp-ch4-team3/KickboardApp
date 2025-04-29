//
//  HomeBottomSheetViewController.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/29/25.
//

import UIKit

final class HomeBottomSheetViewController: UIViewController {
    private let homeBottomSheetView = HomeBottomSheetView()

    var kickboard: Kickboard?

    override func loadView() {
        view = homeBottomSheetView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        homeBottomSheetView
            .configure(
                with: kickboard ?? Kickboard(
                    id: UUID(),
                    latitude: 31.123412,
                    longitude: 125.123412,
                    battery: 75,
                    isAvailable: true,
                    brand: Brand(
                        title: "SWING",
                        imageName: "logo",
                        distancePerBatteryUnit: 4,
                        pricePerMinute: 180
                    )
                )
            )
    }

}
