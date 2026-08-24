//
//  WebViewControllerSpy.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 24.08.2026.
//

import Foundation

final class WebViewControllerSpy: WebViewViewControllerProtocol {
    var presenter: WebViewPresenterProtocol?
    var requestDidLoadCalled: Bool = false

    func load(request: URLRequest) {
        requestDidLoadCalled = true
    }
    
    func setProgressValue(_ newValue: Float) {}
    func setProgressHidden(_ isHidden: Bool) {}
}
