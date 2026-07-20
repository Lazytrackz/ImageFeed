//
//  UIBlockingProgressHUD.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 10.07.2026.
//

import ProgressHUD
import UIKit

// MARK: - UIBlockingProgressHUD

final class UIBlockingProgressHUD {
    
    // MARK: - private properties
    
    private static var window: UIWindow? {
        return UIApplication.shared.windows.first
    }
    
    // MARK: - methods
    
    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.animate()
    }
    
    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
}
