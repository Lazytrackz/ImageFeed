//
//  ImagesListViewPresenterSpy.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 24.08.2026.
//

import Foundation

final class ImagesListViewPresenterSpy: ImagesListViewPresenterProtocol {
    var view: ImagesListViewControllerProtocol?
    var viewDidLoad = false
    var nextPhotoIsFetched = false
    
    func imagesListViewDidLoad() {
        viewDidLoad = true
    }
    
    func updateLike(photoId: String, isLike: Bool) {}
    
    func fetchPhotosNextPage() {
        nextPhotoIsFetched = true
    }
    
    func configTableViewAnimated(photos: [Photo]) {}
}
