//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 31.05.2026.
//

import UIKit

//MARK: - ImagesListCell

final class ImagesListCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    //TODO: добавить UIView с градиентом
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ImagesListCell"
}
