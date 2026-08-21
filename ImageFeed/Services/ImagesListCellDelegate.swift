//
//  ImagesListCellDelegate.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 02.08.2026.
//

import Foundation

protocol ImagesListCellDelegate: AnyObject {
    func imageListCellDidTapLike(_ cell: ImagesListCell)
}
