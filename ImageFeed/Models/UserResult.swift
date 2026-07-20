//
//  UserResult.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 12.07.2026.
//

import Foundation

//MARK: - UserResult

struct UserResult: Codable {
    let profileImage: ImageSize
    private enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
}

//MARK: - ImageSize

struct ImageSize: Codable {
    let small: String
    let medium: String
    let large: String
}
