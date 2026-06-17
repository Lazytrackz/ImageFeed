//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 06.06.2026.
//


import UIKit

//MARK: - ProfileViewController

final class ProfileViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var profileImageView: UIImageView = UIImageView()
    private var nameLabel: UILabel = UILabel()
    private var loginNameLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    private var logOutButton: UIButton = UIButton()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    // MARK: - Actions
    
    @objc private func didTapLogoutButton() {}
    
    
    // MARK: - Private methods
    
    private func makeProfileImageView() {
        let profileImage = UIImage(named: "Profile_photo")
        profileImageView = UIImageView(image: profileImage)
        profileImageView.tintColor = .gray
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
    }
    
    private func makeNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = UIColor(named: "YP White (iOS)")
        nameLabel.font = .boldSystemFont(ofSize: 23)
        view.addSubview(nameLabel)
    }
    
    private func makeLoginNameLabel() {
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        loginNameLabel.text = "@ekaterina_nov"
        loginNameLabel.textColor = UIColor(named: "YP Gray (iOS)")
        loginNameLabel.font = .systemFont(ofSize: 13)
        view.addSubview(loginNameLabel)
    }
    
    private func makeDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Hello, world!"
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
        logOutButton.tintColor = .red
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
