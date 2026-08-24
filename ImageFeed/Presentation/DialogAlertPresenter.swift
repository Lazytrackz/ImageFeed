//
//  DialogAlertPresenter.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 06.08.2026.
//

import Foundation
import UIKit

//MARK: - DialogAlertPresenter

final class DialogAlertPresenter {
    
    // MARK: - Public methods
    
    func show(alertModel: DialogAlertModel, controller: UIViewController, isYes: Bool, accessibilityId: String) {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert
        )
        alert.view.accessibilityIdentifier = accessibilityId
        
        let yesAction = UIAlertAction(title: alertModel.buttonYesText, style: .default){ _ in alertModel.completion(isYes)}
        
        let noAction = UIAlertAction(title: alertModel.buttonNoText, style: .default){ _ in alertModel.completion(!isYes)
            
        }
        alert.addAction(yesAction)
        alert.addAction(noAction)
        controller.present(alert, animated: true, completion: nil)
    }
}
