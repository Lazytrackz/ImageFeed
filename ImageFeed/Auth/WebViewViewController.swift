//
//  WebViewViewController.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 21.06.2026.
//

import WebKit
import UIKit

// MARK: - WebViewViewController

final class WebViewViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - properties
    
    weak var delegate: WebViewViewControllerDelegate?
    private var alertPresenter: AlertPresenter = AlertPresenter()
    private var estimatedProgressObservation: NSKeyValueObservation?
    private var splashView: SplashViewController?
    
    
    // MARK: - lifecircle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        loadAuthView()
        estimatedProgressObservation = webView.observe(
            \.estimatedProgress,
             options: [],
             changeHandler: { [weak self] _, _ in
                 guard let self = self else { return }
                 self.updateProgress()
             })
        updateProgress()
    }
    
    // MARK: - private methods
    
    private func updateProgress() {
        progressView.progress = Float(webView.estimatedProgress)
        progressView.isHidden = fabs(webView.estimatedProgress - 1.0) <= 0.0001
    }
    
    private func loadAuthView() {
        guard var urlComponents = URLComponents(string: UrlConstants.unsplashAuthorizeURLString) else {
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name: URLQueryItemConstants.clientId, value: UrlConstants.accessKey),
            URLQueryItem(name: URLQueryItemConstants.redirectUri, value: UrlConstants.redirectURI),
            URLQueryItem(name: URLQueryItemConstants.responseType, value: URLQueryItemConstants.code),
            URLQueryItem(name: URLQueryItemConstants.scope, value: UrlConstants.accessScope)
        ]
        guard let url = urlComponents.url else {
            print("Invalid url")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
        updateProgress()
    }
}

// MARK: - extension

extension WebViewViewController: WKNavigationDelegate {
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
    
    // MARK: - private methods
    
    private func code(from navigationAction: WKNavigationAction) -> String? {
        if
            let url = navigationAction.request.url,
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == URLQueryItemConstants.urlComponentsPath,
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == URLQueryItemConstants.code })
        {
            return codeItem.value
            
        } else {
            return nil
        }
    }
}
