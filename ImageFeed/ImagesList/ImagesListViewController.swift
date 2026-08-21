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

final class ImagesListViewController: UIViewController, ImagesListViewControllerProtocol {
    
    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Properties
    
    private let logger = Logger(label: "ImageFeed.ImagesListViewController.")
    var photos: [Photo] = []
    private var isLoading: Bool = false
    private var ImagesListServiceObserver: NSObjectProtocol?
    var presenter: ImagesListViewPresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.imagesListViewDidLoad()
        observeImageList()
    }
    
    // MARK: - Public methods
    
    func tableViewConfig() {
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    func updatePhotoList(photos: [Photo]) {
        self.photos = photos
    }
    
    func updateTableViewAnimated(oldIndex: Int, newIndex: Int) {
        isLoading = true
        var indexPaths: [IndexPath] = []
        for photo in oldIndex..<newIndex {
            indexPaths.append(IndexPath(row: photo, section: 0))
        }
        tableView.performBatchUpdates {
            self.tableView.insertRows(at: indexPaths, with: .automatic)
        } completion: { _ in }
    }
    
    // MARK: - Override methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.showSingleImageSegueIdentifier {
            guard
                let viewController = segue.destination as? SingleImageViewController,
                let indexPath = sender as? IndexPath
            else {
                print("Invalid segue destination")
                return
            }
            let profileFullImageURL = photos[indexPath.row].largeImageURL //презентер
            guard let urlImage = URL(string: profileFullImageURL) else { return }
            viewController.setImageURL(newImageURL: urlImage)
            
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    // MARK: - Private methods
    
    private func observeImageList() {
        presenter?.fetchPhotosNextPage()
        ImagesListServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ImagesListService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                presenter?.configTableViewAnimated(photos: photos)
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
    
    // MARK: - Public methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Identifier.showSingleImageSegueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath, cell: ImagesListCell) -> CGFloat {
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
    
    // MARK: - Public methods
    
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
    
    // MARK: - Public methods
    
    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let photo = photos[indexPath.row]
        let id = photo.id
        let isLike = photo.isLiked
        cell.setIsLiked(isLiked: !isLike)
        self.presenter?.updateLike(photoId: id, isLike: isLike)
    }
}
