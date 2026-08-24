//
//  ImagesListCellDelegate.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 02.08.2026.
//

import Foundation

//MARK: - ImagesListCellDelegate

protocol ImagesListCellDelegate: AnyObject {
    
    //MARK: - Public methods
    
    func imageListCellDidTapLike(_ cell: ImagesListCell)
}
