//
//  WebViewViewController.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 21.06.2026.
//

import WebKit
import UIKit

// MARK: - WebViewViewController

final class WebViewViewController: UIViewController, WebViewViewControllerProtocol {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Properties
    
    weak var delegate: WebViewViewControllerDelegate?
    private var alertPresenter: AlertPresenter = AlertPresenter()
    private var estimatedProgressObservation: NSKeyValueObservation?
    private var splashView: SplashViewController?
    var presenter: WebViewPresenterProtocol?
    
    // MARK: - Lifecircle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.accessibilityIdentifier = Identifier.webViewIdentifier
        webView.navigationDelegate = self
        presenter?.viewDidLoad()
        observeProgressView()
    }
    
    // MARK: - Public methods
    
    func setProgressValue(_ newValue: Float) {
        progressView.progress = newValue
    }
    
    func setProgressHidden(_ isHidden: Bool) {
        progressView.isHidden = isHidden
    }
    
    func load(request: URLRequest) {
        webView.load(request)
    }
    
    // MARK: - Private methods
    
    private func observeProgressView() {
        estimatedProgressObservation = webView.observe(
            \.estimatedProgress,
             options: [],
             changeHandler: { [weak self] _, _ in
                 guard let self = self else { return }
                 presenter?.didUpdateProgressValue(webView.estimatedProgress)
             })
    }
}

// MARK: - Extension

extension WebViewViewController: WKNavigationDelegate {
    
    // MARK: - Public methods
    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        if let code = code(from: navigationAction) {
            delegate?.webViewViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    // MARK: - Private methods
    
    private func code(from navigationAction: WKNavigationAction) -> String? {
        if let url = navigationAction.request.url {
            return presenter?.code(from: url)
        }
        return nil
    }
}
