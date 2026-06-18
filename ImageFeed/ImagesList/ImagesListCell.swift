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
    
    @IBOutlet weak private var cellImage: UIImageView!
    @IBOutlet weak private var likeButton: UIButton!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var gradientImage: UIImageView!
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ImagesListCell"
    private var imageForCell: UIImage?
    private var rowIndex: Int?
    private let gradientRectangleImage = UIImage(named: "Rectangle")
    private let today = Date()
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: - Methods
    
    func configCell() {
        gradientImage.image = gradientRectangleImage
        cellImage.image = imageForCell
        dateLabel.text = dateFormatter.string(from: today)
        guard let rowIndex else {return}
        likeButton.setImage(UIImage(resource: rowIndex % 2 == 0 ? .active : .noActive), for: .normal)
    }
    
    func setCellImage(newImage: UIImage) {
        imageForCell = newImage
    }
    
    func setRow(currentRow: Int) {
        rowIndex = currentRow
    }
    
  
      
        
    
    
    
  
    
    
    
}
