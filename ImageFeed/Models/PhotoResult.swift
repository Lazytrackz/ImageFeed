//
//  PhotoResult.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 25.07.2026.
//

import Foundation

//MARK: - PhotoResult

struct PhotoResult: Codable {
    let id: String
    let createdAt: String?
    let width: Int
    let height: Int
    let description: String?
    let isLiked: Bool
    let urls: UrlsResult
    
    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width
        case height
        case description
        case isLiked = "liked_by_user"
        case urls
    }
}

//MARK: - UrlsResult

struct UrlsResult: Codable {
    let full: String
    let thumb: String
}
