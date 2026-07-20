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
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
