//
//  Photo.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 24.07.2026.
//

import Foundation

//MARK: - Photo

public struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool
}

extension Photo {
    init(photo: Photo, isLiked: Bool) {
        self.id = photo.id
        self.size = photo.size
        self.createdAt = photo.createdAt
        self.welcomeDescription = photo.welcomeDescription
        self.thumbImageURL = photo.thumbImageURL
        self.largeImageURL = photo.largeImageURL
        self.isLiked = isLiked
    }
}
