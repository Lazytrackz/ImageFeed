//
//  Photo.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 24.07.2026.
//

import Foundation

//MARK: - Photo

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool
}
