//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 21.06.2026.
//

import UIKit
import SwiftKeychainWrapper

// MARK: - AuthViewController:

final class AuthViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var webView: WebViewViewController = WebViewViewController()
    private var alertPresenter: AlertPresenter = AlertPresenter()
    private var splashView: SplashViewController?
    
    // MARK: - Properties
    
    weak var delegate: AuthViewControllerDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
    }
    
    // MARK: - Override methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Identifier.segueWebViewIdentifier else {
            super.prepare(for: segue, sender: sender)
            return
        }
        
        guard let webViewViewController = segue.destination as? WebViewViewController
        else {
            super.prepare(for: segue, sender: sender)
            assertionFailure("Failed to prepare for \(Identifier.segueWebViewIdentifier)")
            return
        }
        
        let authHelper = AuthHelper()
        let webViewPresenter = WebViewPresenter(authHelper: authHelper)
        webViewViewController.presenter = webViewPresenter
        webViewPresenter.view = webViewViewController
        webViewViewController.delegate = self
    }
    
    // MARK: - Private methods
    
    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "nav_back_button")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_back_button")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(named: "YP Black (iOS)")
    }
}

// MARK: - Extension

extension AuthViewController: WebViewViewControllerDelegate {
    
    // MARK: - Public Methods
    
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        vc.dismiss(animated: true)
        UIBlockingProgressHUD.show()
        OAuth2Service.shared.fetchOAuthToken(code) { [weak self] result in
            UIBlockingProgressHUD.dismiss()
            guard let self else {
                return }
            switch result {
            case .success:
                print("done")
                self.delegate?.didAuthenticate(self)
            case .failure:
                self.showAuthError()
                print("Error fetching token")
                break
            }
        }
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        vc.dismiss(animated: true)
    }
    
    func showAuthError() {
        let alertModel = AlertModel(title: AlertsConstants.authErrorHeader,
                                    message: AlertsConstants.authErrorMessage,
                                    buttonText: AlertsConstants.authErrorButtonText){ [weak self] in guard let self = self else { return }
            webViewViewControllerDidCancel(webView)
            splashView?.checkToken()
        }
        alertPresenter.show(alertModel: alertModel, controller: self, accessibilityId: "AuthError")
    }
}
