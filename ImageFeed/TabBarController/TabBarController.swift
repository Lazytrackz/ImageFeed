//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 17.07.2026.
//


import UIKit

// MARK: - TabBarController

final class TabBarController: UITabBarController {
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarAppearance()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViewControllers()
    }
    
    // MARK: - Private methods
    
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
        ) as! ImagesListViewController
        
        let profileViewController = ProfileViewController()
        let profilePresenter = ProfilePresenter()
        profilePresenter.view = profileViewController
        profileViewController.presenter = profilePresenter
        let imagesListPresenter = ImagesListViewPresenter()
        imagesListPresenter.view = imagesListViewController
        imagesListViewController.presenter = imagesListPresenter
        
        profileViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "tab_profile_active"),
            selectedImage: nil
        )
        self.viewControllers = [imagesListViewController, profileViewController]
    }
}
