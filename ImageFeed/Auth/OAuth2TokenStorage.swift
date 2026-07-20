//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 28.06.2026.
//

import Foundation

// MARK: - OAuth2TokenStorage

final class OAuth2TokenStorage {
    
    // MARK: - private properties
    
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "access_token")
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: "access_token")
        }
    }
}
