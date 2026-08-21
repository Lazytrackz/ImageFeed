//
//  AppDelegate.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 28.05.2026.
//

import UIKit
import ProgressHUD

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private func configureProgressHud() {
        ProgressHUD.animationType = .activityIndicator
        ProgressHUD.colorHUD = .white
        ProgressHUD.colorAnimation = .black
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureProgressHud()
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfiguration = UISceneConfiguration(
            name: "Main",
            sessionRole: connectingSceneSession.role
        )
        sceneConfiguration.delegateClass = SceneDelegate.self
        return sceneConfiguration
    }
}

