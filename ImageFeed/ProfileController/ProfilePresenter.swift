//
//  ProfilePresenter.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 13.08.2026.
//

import Foundation
import UIKit

//MARK: - ProfilePresenter

final class ProfilePresenter: ProfilePresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: ProfileViewControllerProtocol?
    
    // MARK: - Methods
    
    func configLogoutAlert(_ isYes: Bool) {
        let alertModel = DialogAlertModel(title: AlertsConstants.logoutHeader,
                                          message: AlertsConstants.logoutMessage,
                                          buttonYesText: AlertsConstants.logoutButtonYes,
                                          buttonNoText: AlertsConstants.logoutButtonNo){ [weak self] isYes in guard let self else {
                                              return }
            if isYes {
                ProfileLogoutService.shared.logout()
                view?.showSplashWindow()
            }
        }
        view?.showLogoutAlert(alert: alertModel, isYes: isYes)
    }
    
    func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let urlImage = URL(string: profileImageURL)
        else { return }
        view?.configProfileImage(urlImage: urlImage)
    }
    
    func updateProfile() {
        guard let profile = ProfileService.shared.profile else { return }
        view?.configProfile(profile: profile)
        
    }
    
    func loadProfileView() {
        view?.configProfileView()
    }
}
