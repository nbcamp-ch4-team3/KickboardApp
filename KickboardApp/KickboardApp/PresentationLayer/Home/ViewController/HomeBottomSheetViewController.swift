//
//  HomeBottomSheetViewController.swift
//  KickboardApp
//
//  Created by 송규섭 on 4/29/25.
//

import UIKit

protocol HomeBottomSheetVCDelegate: AnyObject {
    func didTapConfirmButton()
    func didBottomSheetDismissed()
}

final class HomeBottomSheetViewController: UIViewController {
    private let homeBottomSheetView = HomeBottomSheetView()

    weak var delegate: HomeBottomSheetVCDelegate?

    override func loadView() {
        view = homeBottomSheetView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        homeBottomSheetView.delegate = self
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.didBottomSheetDismissed()
    }

    func configure(with kickboard: Kickboard) {
        homeBottomSheetView.configure(with: kickboard)
    }
}

extension HomeBottomSheetViewController: HomeBottomSheetViewDelegate {
    func didTapRentButton() {
        let alert = UIAlertController(
            title: "킥보드를 대여하시겠어요?",
            message: "대여 후 이용 요금이 부과됩니다.\n계속 진행하시겠습니까?",
            preferredStyle: .alert
        )
        let confirm = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self else { return }
            self.delegate?.didTapConfirmButton()
            self.dismiss(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(confirm)
        alert.addAction(cancel)

        present(alert, animated: true)
    }
}
