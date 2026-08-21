//
//  ProfilePresenterProtocol.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 13.08.2026.
//

import Foundation

//MARK: - ProfilePresenterProtocol

public protocol ProfilePresenterProtocol: AnyObject {
    
    //MARK: - Properties
    
    var view: ProfileViewControllerProtocol? { get set }
    
    //MARK: - Public methods
    
    func loadProfileView()
    func configLogoutAlert(_ isYes: Bool)
    func updateAvatar() 
    func updateProfile() 
}
