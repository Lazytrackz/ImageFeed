//
//  ProfileViewTests.swift
//  ImageFeedTests
//
//  Created by Aleksey Kosichenko on 14.08.2026.
//

@testable import ImageFeed
import Foundation
import XCTest


final class ProfileViewTests: XCTestCase {
        
    func testViewControllerViewDidLoad() {
        
        // Given
        
        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        viewController.presenter = presenter
        
        // When
        
        _ = viewController.view
        
        // Then
        
        XCTAssertTrue(presenter.viewDidLoad)
    }
    
    func testViewControllerUpdateAvatar() {
        
        // Given
        
        let viewController = ProfileViewControllerSpy()
        let presenter = ProfilePresenter()
        viewController.presenter = presenter
        guard let urlImage = URL(string: "test_url") else { return }
        
        // When
        
        viewController.configProfileImage(urlImage: urlImage)
        
        // Then
        
        XCTAssertTrue(viewController.updatedAvatar)
    }
    
    func testViewControllerUpdateProfile() {
        
        // Given
        
        let viewController = ProfileViewControllerSpy()
        let presenter = ProfilePresenter()
        viewController.presenter = presenter
        let profile = Profile(username: "Test_username",
                              name: "Test_name",
                              loginName: "Test_loginname",
                              bio: "Test_bio")
        
        // When
        
        viewController.configProfile(profile: profile)
        
        // Then
        
        XCTAssertTrue(viewController.updatedProfile)
    }
}
