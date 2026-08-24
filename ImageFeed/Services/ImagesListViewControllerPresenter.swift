//
//  ImagesListViewControllerPresenter.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 15.08.2026.
//

import Foundation

//MARK: - ImagesListViewPresenterProtocol

public protocol ImagesListViewPresenterProtocol: AnyObject {
    
    //MARK: - Properties
    
    var view: ImagesListViewControllerProtocol? { get set }
    
    //MARK: - Public methods
    
    func imagesListViewDidLoad()
    func updateLike(photoId: String, isLike: Bool)
    func fetchPhotosNextPage()
    func configTableViewAnimated(photos: [Photo])
}
