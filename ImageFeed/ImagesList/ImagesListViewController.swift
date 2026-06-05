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
    
    // MARK: - Properties
    
    private let logger = Logger(label: "ImageFeed.ImagesListViewController.")
    private let photosName: [String] = Array(0..<20).map{ "\($0)" }
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
    }
    
    // MARK: - Private methods
    
    private func tableViewConfig() {
        tableView.rowHeight = 200
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
}

// MARK: - Extensions

extension ImagesListViewController {
    
    // MARK: - Private methods
    
    private func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return
        }
        cell.cellImage?.image = image
        cell.dateLabel?.text = dateFormatter.string(from: Date())
        
        if indexPath.row % 2 == 0 {
            cell.likeButton?.setImage(UIImage(named: "Active"), for: .normal)
        }
        else {
            cell.likeButton?.setImage(UIImage(named: "No_active"), for: .normal)
        }
    }
}

extension ImagesListViewController: UITableViewDelegate {
    
    // MARK: - Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
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

extension ImagesListViewController: UITableViewDataSource{
    
    // MARK: - Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
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

