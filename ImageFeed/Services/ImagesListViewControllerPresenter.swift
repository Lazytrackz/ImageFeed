//
//  ImagesListViewControllerPresenter.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 15.08.2026.
//

import Foundation


public protocol ImagesListViewPresenterProtocol: AnyObject {
    
    var view: ImagesListViewControllerProtocol? { get set }
    
    func imagesListViewDidLoad()
    func updateLike(photoId: String, isLike: Bool)
    func fetchPhotosNextPage()
    func configTableViewAnimated(photos: [Photo])
    
   
    
    
}
