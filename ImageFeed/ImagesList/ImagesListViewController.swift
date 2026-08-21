//
//  ViewController.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 28.05.2026.
//

import UIKit
import Logging
import Kingfisher

//MARK: - ImagesListViewController

final class ImagesListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Private properties
    
    private let logger = Logger(label: "ImageFeed.ImagesListViewController.")
    var photos: [Photo] = []
    private var isLoading: Bool = false
    private var ImagesListServiceObserver: NSObjectProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
        observeImageList()
    }
    
    // MARK: - Private methods
    
    private func tableViewConfig() {
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    private func observeImageList() {
        ImagesListService.shared.fetchPhotosNextPage()
        ImagesListServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ImagesListService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.updateTableViewAnimated()
            }
    }
    
    private func updateTableViewAnimated() {
        isLoading = true
        let newIndex = ImagesListService.shared.photos.count
        let oldIndex = photos.count
        photos = ImagesListService.shared.photos
        var indexPaths: [IndexPath] = []
        for photo  in oldIndex..<newIndex {
            indexPaths.append(IndexPath(row: photo, section: 0))
        }
        tableView.performBatchUpdates {
            self.tableView.insertRows(at: indexPaths, with: .automatic)
        } completion: { _ in }
    }
    
    // MARK: - Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.showSingleImageSegueIdentifier {
            guard
                let viewController = segue.destination as? SingleImageViewController,
                let indexPath = sender as? IndexPath
            else {
                print("Invalid segue destination")
                return
            }
            let profileFullImageURL = photos[indexPath.row].largeImageURL
            guard let urlImage = URL(string: profileFullImageURL) else { return }
            viewController.setImageURL(newImageURL: urlImage)
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

// MARK: - Extensions

extension ImagesListViewController {
    
    // MARK: - Private methods
    
    private func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        if isLoading {
            let profileThumbImageURL = photos[indexPath.row].thumbImageURL
            guard let urlImage = URL(string: profileThumbImageURL) else { return }
            let photoDate = photos[indexPath.row].createdAt
            let isLike = photos[indexPath.row].isLiked
            cell.delegate = self
            cell.configCellImage(urlImage: urlImage, imageDate: photoDate)
            cell.setIsLiked(isLiked: isLike)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            self.tableView.reloadData()
        }
    }
}

extension ImagesListViewController: UITableViewDelegate {
    
    // MARK: - Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Identifier.showSingleImageSegueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath, cell: ImagesListCell ) -> CGFloat {
        let imageHeight = photos[indexPath.row].size.height
        let imageWidth  = photos[indexPath.row].size.width
        let horizontalIndents: CGFloat = 32
        let verticalIndents: CGFloat = 8
        let cellWidth = tableView.bounds.width - horizontalIndents
        let cellDynamicHeight = imageHeight * (cellWidth / imageWidth) + verticalIndents
        return cellDynamicHeight
    }
}

extension ImagesListViewController: UITableViewDataSource {
    
    // MARK: - Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.imagesListCellIdentifier, for: indexPath)
        guard let imageListCell = cell as? ImagesListCell else {
            logger.warning("Failed to load cell")
            return UITableViewCell()
        }
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath
    ) {
        if photos.count != 0 {
            if indexPath.row == photos.count - 1 {
                isLoading = false
                observeImageList()
            }
        }
    }
}

extension ImagesListViewController: ImagesListCellDelegate {
    
    // MARK: - Methods
    
    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let photo = photos[indexPath.row]
        let id = photo.id
        let isLike = photo.isLiked
        UIBlockingProgressHUD.show()
        ImagesListService.shared.changeLike(photoId: id, isLike: !isLike) { [weak self] result in
            guard let self else {
                return }
            switch result {
            case .success:
                self.photos = ImagesListService.shared.photos
                cell.setIsLiked(isLiked: self.photos[indexPath.row].isLiked)
                UIBlockingProgressHUD.dismiss()
            case .failure:
                UIBlockingProgressHUD.dismiss()
                print("Error fetching data")
            }
        }
    }
}
