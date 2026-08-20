//
//  ImagesListViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 15.08.2026.
//

import Foundation
import UIKit

public protocol ImagesListViewControllerProtocol: AnyObject {
    
    var presenter: ImagesListViewPresenterProtocol? { get set }
  
    
    func tableViewConfig()
    func updatePhotoList(photos: [Photo])
    func updateTableViewAnimated(oldIndex: Int, newIndex: Int)

}
