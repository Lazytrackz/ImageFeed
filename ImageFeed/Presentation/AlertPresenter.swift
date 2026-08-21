//
//  AlertPresenter.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 14.07.2026.
//
import UIKit

//MARK: - AlertPresenter

final class AlertPresenter {
    
    // MARK: - Public methods
    
    func show(alertModel: AlertModel, controller: UIViewController, accessibilityId: String) {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert
        )
        alert.view.accessibilityIdentifier = accessibilityId
        let action = UIAlertAction(title: alertModel.buttonText, style: .default){ _ in
            alertModel.completion()
        }
        alert.addAction(action)
        controller.present(alert, animated: true, completion: nil)
    }
}
