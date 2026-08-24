//
//  ProfileViewPresenterSpy.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 24.08.2026.
//

import Foundation

final class ProfileViewPresenterSpy: ProfilePresenterProtocol {
    var view: ProfileViewControllerProtocol?
    var viewDidLoad = false
    var logoutAlertIsConfigured = false
    
    func loadProfileView() {
        viewDidLoad = true
    }
    
    func configLogoutAlert(_ isYes: Bool) {
        logoutAlertIsConfigured = true
    }
    
    func updateAvatar() {}
    func updateProfile() {}
}
