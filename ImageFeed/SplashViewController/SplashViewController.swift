//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 30.06.2026.
//

import UIKit
//import ProgressHUD

// MARK: - SplashViewController

final class SplashViewController: UIViewController {
    
    
    // MARK: - Private properties
    
    private let storage = OAuth2TokenStorage()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSplashController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkToken()
    }
    
    // MARK: - Private methods
    
    private func fetchProfile(_ token: String) {
        UIBlockingProgressHUD.show()
        ProfileService.shared.fetchProfile(token) { [weak self] result in
            UIBlockingProgressHUD.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                ProfileImageService.shared.fetchProfileImageURL(username: profile.username) { _ in }
                self.switchToTabBarController()
                
            case .failure:
                print("Error fetching data")
                break
            }
        }
    }
        
    private func showAuthWindow() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: Identifier.authViewControllerIdentifier) as? AuthViewController else {
            print("Invalid identifier")
            return
        }
        viewController.delegate = self
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
    
    private func switchToTabBarController() {
        let window = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: Identifier.tabBarViewControllerIdentifier)
        window?.rootViewController = tabBarController
    }
    
    private func configureSplashController() {
        self.view.backgroundColor = .ypBlackIOS
        let logoImage = UIImage(named: "launch_screen_logo")
        let splashScreenImageView = UIImageView(image: logoImage)
        splashScreenImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(splashScreenImageView)
        splashScreenImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        splashScreenImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    // MARK: - methods
    
    func checkToken() {
        if storage.token != nil{
            guard let token = OAuth2TokenStorage().token else { return }
            fetchProfile(token)
        } else {
            showAuthWindow()
        }
    }
}

// MARK: - Extension

extension SplashViewController: AuthViewControllerDelegate {
    
    // MARK: - methods
    
    func didAuthenticate(_ vc: AuthViewController) {
        vc.dismiss(animated: true)
        guard let token = OAuth2TokenStorage().token else { return }
        fetchProfile(token)
    }
}
