//
//  WebViewViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 21.06.2026.
//

import Foundation

//MARK: - WebViewViewControllerDelegate

protocol WebViewViewControllerDelegate: AnyObject {
    
    // MARK: - Public methods
    
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}
