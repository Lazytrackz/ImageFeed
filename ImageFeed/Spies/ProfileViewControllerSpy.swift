//
//  ProfileViewControllerSpy.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 24.08.2026.
//

import Foundation

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    var presenter: ProfilePresenterProtocol?
    var updatedAvatar = false
    var updatedProfile = false
    
    func configProfileView() {}
    
    func configProfile(profile: Profile) {
        updatedProfile = true
    }
    
    func showLogoutAlert(alert: DialogAlertModel, isYes: Bool) {}
    func showSplashWindow() {}
    
    func configProfileImage(urlImage: URL) {
        updatedAvatar = true
    }
}
