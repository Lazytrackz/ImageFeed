//
//  ImagesListViewPresenter.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 15.08.2026.
//

import Foundation

//MARK: - ImagesListViewPresenter

final class ImagesListViewPresenter: ImagesListViewPresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: ImagesListViewControllerProtocol?
    
    //MARK: - Public methods
    
    func imagesListViewDidLoad() {
        view?.tableViewConfig()
    }
    
    func fetchPhotosNextPage() {
        ImagesListService.shared.fetchPhotosNextPage()
    }
    
    func configTableViewAnimated(photos: [Photo]) {
        let newIndex = ImagesListService.shared.photos.count
        let oldIndex = photos.count
        view?.updatePhotoList(photos: ImagesListService.shared.photos)
        view?.updateTableViewAnimated(oldIndex: oldIndex, newIndex: newIndex)
    }
    
    func updateLike(photoId: String, isLike: Bool) {
        UIBlockingProgressHUD.show()
        ImagesListService.shared.changeLike(photoId: photoId, isLike: !isLike) { [weak self] result in
            guard let self else {
                return }
            switch result {
            case .success:
                view?.updatePhotoList(photos: ImagesListService.shared.photos)
                UIBlockingProgressHUD.dismiss()
            case .failure:
                UIBlockingProgressHUD.dismiss()
                print("Error fetching data")
            }
        }
    }
}
