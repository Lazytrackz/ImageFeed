//
//  ProfileViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 13.08.2026.
//

import Foundation

//MARK: - ProfileViewControllerProtocol

public protocol ProfileViewControllerProtocol: AnyObject {
    
    //MARK: - Properties
    
    var presenter: ProfilePresenterProtocol? { get set }
    
    //MARK: - Public methods
    
    func configProfileView()
    func configProfile(profile: Profile)
    func showLogoutAlert(alert: DialogAlertModel, isYes: Bool)
    func showSplashWindow()
    func configProfileImage(urlImage: URL) 
}
