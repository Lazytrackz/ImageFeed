//
//  ImagesListViewControllerSpy.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 24.08.2026.
//

import Foundation

final class ImagesListViewControllerSpy: ImagesListViewControllerProtocol {
    var presenter: (any ImageFeed.ImagesListViewPresenterProtocol)?
    var photosIsUpdated = false
    var isUpdatedTableViewAnimated = false
    var tableViewIsConfigured = false
    
    func tableViewConfig() {
        tableViewIsConfigured = true
    }
    
    func updatePhotoList(photos: [Photo]) {
        photosIsUpdated = true
    }
    
    func updateTableViewAnimated(oldIndex: Int, newIndex: Int) {
        isUpdatedTableViewAnimated = true
    }
}
