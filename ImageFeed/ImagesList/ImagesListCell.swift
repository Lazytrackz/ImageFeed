//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 31.05.2026.
//

import UIKit
import Kingfisher

//MARK: - ImagesListCell

final class ImagesListCell: UITableViewCell {
  
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var cellImage: UIImageView!
    @IBOutlet weak private var likeButton: UIButton!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var gradientImage: UIImageView!
    
    // MARK: - Properties
    
    var presenter: ImagesListViewPresenterProtocol? 
    
    weak var delegate: ImagesListCellDelegate?
    private let gradientRectangleImage = UIImage(named: "Rectangle")
    private let today = Date()
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: - IBActions
    
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        delegate?.imageListCellDidTapLike(self)
    }
    
    // MARK: - Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImage.kf.cancelDownloadTask()
    }
    
    func configCellImage(urlImage: URL, imageDate: Date?){
        cellImage.kf.indicatorType = .activity
        cellImage.kf.setImage(
            with: urlImage,
            placeholder: UIImage(named: "PhotosStub")
        ) { result in
            switch result {
            case .success(_):
                self.gradientImage.image = self.gradientRectangleImage
                let date = imageDate ?? self.today
                self.dateLabel.text = self.dateFormatter.string(from: date)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setIsLiked(isLiked: Bool) {
        likeButton.setImage(UIImage(resource: isLiked == true ? .active: .noActive), for: .normal)
    }
    
    
    
    

    
   
    
    
}
