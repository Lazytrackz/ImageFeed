//
//  ProfileLogoutService.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 03.08.2026.
//

import Foundation
import WebKit
import SwiftKeychainWrapper

//MARK: - ProfileLogoutService

final class ProfileLogoutService {
    
    //MARK: - Properties
    
    static let shared = ProfileLogoutService()
    private init() { }
    
    //MARK: - Public methods
    
    func logout() {
        cleanCookies()
        clearToken()
        clearProfile()
    }
    
    //MARK: - Private Methods
    
    private func cleanCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
    
    private func clearToken() {
        KeychainWrapper.standard.removeObject(forKey: Identifier.accessToken)
    }
    
    private func clearProfile() {
        ProfileService.shared.clearProfile()
        ProfileImageService.shared.clearAvatar()
        ImagesListService.shared.clearPhotos()
    }
    
}
