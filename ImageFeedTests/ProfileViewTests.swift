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
        
        func updateAvatar() {
            
        }
        
        func updateProfile() {
            
        }
    }
    
    final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
        var presenter: ProfilePresenterProtocol?
        var updatedAvatar = false
        var updatedProfile = false
        
        
        func configProfileView() {
            
        }
        
        func configProfile(profile: Profile) {
            updatedProfile = true
        }
        
        func showLogoutAlert(alert: DialogAlertModel, isYes: Bool) {
            
        }
        
        func showSplashWindow() {
            
        }
        
        func configProfileImage(urlImage: URL) {
            updatedAvatar = true
        }
        
    }
    
    
    
    
    func testViewControllerViewDidLoad() {
        //given
        
        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        viewController.presenter = presenter
        //when
        _ = viewController.view
        //then
        XCTAssertTrue(presenter.viewDidLoad)
    }
    
    
    func testViewControllerUpdateAvatar() {
        //given
        let viewController = ProfileViewControllerSpy()
        let presenter = ProfilePresenter()
        viewController.presenter = presenter
        guard let urlImage = URL(string: "test_url") else { return }
        
        //when
        viewController.configProfileImage(urlImage: urlImage)
        
        //then
        
        XCTAssertTrue(viewController.updatedAvatar)
    }
    
    
    func testViewControllerUpdateProfile() {
        //given
        let viewController = ProfileViewControllerSpy()
        let presenter = ProfilePresenter()
        viewController.presenter = presenter
        let profile = Profile(username: "Test_username",
                              name: "Test_name",
                              loginName: "Test_loginname",
                              bio: "Test_bio")
        
        //when
        viewController.configProfile(profile: profile)
        
        //then
        
        XCTAssertTrue(viewController.updatedProfile)
    }
    

}
