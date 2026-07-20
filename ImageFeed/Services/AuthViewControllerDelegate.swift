//
//  AuthViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 01.07.2026.
//

import Foundation

//MARK: - WebViewViewControllerDelegate

protocol AuthViewControllerDelegate: AnyObject {
    
    // MARK: - Private methods
    
    func didAuthenticate(_ vc: AuthViewController)
}
