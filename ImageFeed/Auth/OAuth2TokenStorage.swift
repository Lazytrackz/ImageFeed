//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 28.06.2026.
//

import Foundation
import SwiftKeychainWrapper

// MARK: - OAuth2TokenStorage

final class OAuth2TokenStorage {
    
    // MARK: - Private properties
    
    private let tokenKey = Identifier.accessToken
    
    // MARK: - Properties
    var token: String? {
        get {
            return KeychainWrapper.standard.string(forKey: tokenKey)
        }
        set {
            if let token = newValue {
                KeychainWrapper.standard.set(token, forKey: tokenKey)
            }else{
                KeychainWrapper.standard.removeObject(forKey: tokenKey)
            }
        }
    }
}
