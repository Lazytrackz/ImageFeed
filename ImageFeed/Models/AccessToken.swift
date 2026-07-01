//
//  AccessToken.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 28.06.2026.
//

import Foundation

//MARK: - AccessToken

struct AccessToken: Codable {
    let access_token: String
    let token_type: String
    let scope: String
    let created_at: Int
}
