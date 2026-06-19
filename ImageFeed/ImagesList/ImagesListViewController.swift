//
//  ViewController.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 28.05.2026.
//

import UIKit
import Logging

//MARK: - ImagesListViewController

final class ImagesListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Private properties
    
    private let showSingleImageSegueIdentifier = "ShowSingleImage"
    private let logger = Logger(label: "ImageFeed.ImagesListViewController.")
    private let photosName: [String] = Array(0..<20).map{ "\($0)" }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
    }
    
    // MARK: - Private methods
    
    private func tableViewConfig() {
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    // MARK: - Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showSingleImageSegueIdentifier {
            guard
                let viewController = segue.destination as? SingleImageViewController,
                let indexPath = sender as? IndexPath
            else {
                print("Invalid segue destination")
                return
            }
            let image = UIImage(named: photosName[indexPath.row])
            guard let image else {return}
            viewController.setImage(newImage: image)
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

// MARK: - Extensions

extension ImagesListViewController {
    
    // MARK: - Private methods
    
    private func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return
        }
        cell.setCellImage(newImage: image)
        cell.setRow(currentRow: indexPath.row)
        cell.configCell()
    }
}

extension ImagesListViewController: UITableViewDelegate {
    
    // MARK: - Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showSingleImageSegueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return 0
        }
        let horizontalIndents: CGFloat = 32
        let verticalIndents: CGFloat = 8
        let cellWidth = tableView.bounds.width - horizontalIndents
        let cellDynamicHeight = image.size.height * (cellWidth / image.size.width) + verticalIndents
        return cellDynamicHeight
    }
}

extension ImagesListViewController: UITableViewDataSource {
    
    // MARK: - Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photosName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        guard let imageListCell = cell as? ImagesListCell else {
            logger.warning("Failed to load cell")
            return UITableViewCell()
        }
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
}
