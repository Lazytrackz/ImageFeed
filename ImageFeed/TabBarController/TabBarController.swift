//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 17.07.2026.
//


import UIKit

// MARK: - TabBarController

final class TabBarController: UITabBarController {
    
    // MARK: - methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarAppearance()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViewControllers()
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .ypBlackIOS
        appearance.shadowColor = .clear
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .ypBlackIOS
    }
    
    private func configureViewControllers() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let imagesListViewController = storyboard.instantiateViewController(
            withIdentifier: Identifier.imageListViewControllerIdentifier
        )
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "tab_profile_active"),
            selectedImage: nil
        )
        self.viewControllers = [imagesListViewController, profileViewController]
    }
}
