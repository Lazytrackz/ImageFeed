//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 06.06.2026.
//


import UIKit
import Kingfisher


//MARK: - ProfileViewController

final class ProfileViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var profileImageView: UIImageView = UIImageView()
    private var nameLabel: UILabel = UILabel()
    private var loginNameLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    private var logOutButton: UIButton = UIButton()
    private var profileImageServiceObserver: NSObjectProtocol?
    private var dialogAlertPresenter: DialogAlertPresenter = DialogAlertPresenter()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProfileView()
        observeProfileImage()
    }
    
    // MARK: - Actions
    
    @objc private func didTapLogoutButton() {
        showLogoutAlert(isYes: true)
    }
    
    // MARK: - Private methods
    
    private func showSplashWindow() {
        let viewController = SplashViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
    
    private func showLogoutAlert(isYes: Bool) {
        let alertModel = DialogAlertModel(title: AlertsConstants.logoutHeader,
                                          message: AlertsConstants.logoutMessage,
                                          buttonYesText: AlertsConstants.logoutButtonYes,
                                          buttonNoText: AlertsConstants.logoutButtonNo){ [weak self] isYes in guard let self else {
                                              return }
            if isYes {
                ProfileLogoutService.shared.logout()
                showSplashWindow()
            }
        }
        dialogAlertPresenter.show(alertModel: alertModel, controller: self, isYes: isYes, accessibilityId: "LogoutDialogAlert")
    }
    
    private func observeProfileImage() {
        guard let profile = ProfileService.shared.profile else { return }
        updateProfile(profile: profile)
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.updateAvatar()
            }
        updateAvatar()
    }
    
    private func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let urlImage = URL(string: profileImageURL)
        else { return }
        configProfileImage(urlImage: urlImage)
    }
    
    private func configProfileImage(urlImage: URL) {
        
        let processor = RoundCornerImageProcessor(cornerRadius: 61)
        profileImageView.kf.indicatorType = .activity
        profileImageView.kf.setImage(with: urlImage,
                                     options: [.processor(processor)])
    }
    
    private func updateProfile(profile: Profile) {
        nameLabel.text = profile.name.isEmpty
        ? DefaultsNames.defaultUserName
        : profile.name
        loginNameLabel.text = profile.loginName.isEmpty
        ? DefaultsNames.defaultLoginName
        : profile.loginName
        descriptionLabel.text = (profile.bio?.isEmpty ?? true)
        ? DefaultsNames.defaultDescription
        : profile.bio
    }
    
    private func makeProfileImageView() {
        let profileImage = UIImage(named: "Stub")
        profileImageView = UIImageView(image: profileImage)
        profileImageView.tintColor = .gray
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
    }
    
    private func configProfileView() {
        self.view.backgroundColor = .ypBlackIOS
        makeProfileImageView()
        makeNameLabel()
        makeLoginNameLabel()
        makeDescriptionLabel()
        makeLogOutButton()
        profileImageConstraints()
        nameLabelConstraints()
        loginNameLabelConstraints()
        descriptionLabelConstraints()
        logOutButtonConstraints()
    }
    
    private func makeNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = DefaultsNames.defaultUserName
        nameLabel.textColor = UIColor(named: "YP White (iOS)")
        nameLabel.font = .boldSystemFont(ofSize: 23)
        view.addSubview(nameLabel)
    }
    
    private func makeLoginNameLabel() {
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        loginNameLabel.text = DefaultsNames.defaultLoginName
        loginNameLabel.textColor = UIColor(named: "YP Gray (iOS)")
        loginNameLabel.font = .systemFont(ofSize: 13)
        view.addSubview(loginNameLabel)
    }
    
    private func makeDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = DefaultsNames.defaultDescription
        descriptionLabel.textColor = UIColor(named: "YP White (iOS)")
        descriptionLabel.font = .systemFont(ofSize: 13)
        view.addSubview(descriptionLabel)
    }
    
    private func makeLogOutButton() {
        logOutButton = UIButton.systemButton(
            with: UIImage(systemName: "ipad.and.arrow.forward")!,
            target: self,
            action: #selector(self.didTapLogoutButton)
        )
        logOutButton.tintColor = UIColor(named: "YP Red (iOS)")
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logOutButton)
    }
    
    private func profileImageConstraints() {
        profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func nameLabelConstraints() {
        nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor).isActive = true
    }
    
    private func loginNameLabelConstraints() {
        loginNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        loginNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
    }
    
    private func descriptionLabelConstraints() {
        descriptionLabel.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: loginNameLabel.leadingAnchor).isActive = true
    }
    
    private func logOutButtonConstraints() {
        logOutButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        logOutButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
    }
}
