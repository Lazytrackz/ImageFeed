//
//  ImagesListViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 15.08.2026.
//

import Foundation

//MARK: - ImagesListViewControllerProtocol

public protocol ImagesListViewControllerProtocol: AnyObject {
    
    //MARK: - Properties
    
    var presenter: ImagesListViewPresenterProtocol? { get set }
    
    //MARK: - Public methods
    
    func tableViewConfig()
    func updatePhotoList(photos: [Photo])
    func updateTableViewAnimated(oldIndex: Int, newIndex: Int)
}
