//
//  UIViewController+.swift
//  KickboardApp
//
//  Created by 이수현 on 4/29/25.
//

import UIKit

extension UIViewController {
    func showErrorAlert(error: AppError) {
        let alert = UIAlertController(
            title: error.alertType.rawValue,
            message: error.errorDescription,
            preferredStyle: .alert
        )
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }
}

