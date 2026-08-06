//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 07.06.2026.
//


import UIKit
import Kingfisher

//MARK: - SingleImageViewController

final class SingleImageViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var sharingButton: UIButton!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var scrollView: UIScrollView!
    
    // MARK: - Properties
    
    private var image: UIImage?
    private var imageUrL: URL?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configScrollView()
        configCellImage()
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapShareButton(_ sender: Any) {
        guard let image else { return }
        let activityItems = [image]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: - Private methods
    
    private func configCellImage(){
        
        imageView.kf.indicatorType = .activity
        UIBlockingProgressHUD.show()
        imageView.kf.setImage(
            with: imageUrL,
        ) { result in
            UIBlockingProgressHUD.dismiss()
            switch result {
            case .success(let value):
                self.image = value.image
                self.imageView.frame.size = value.image.size
                self.rescaleAndCenterImageInScrollView(image: value.image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        if imageSize.width > 0 && imageSize.height > 0 {
            let hScale = visibleRectSize.width / imageSize.width
            let vScale = visibleRectSize.height / imageSize.height
            let scale = min(maxZoomScale, max(minZoomScale, min(hScale, vScale)))
            scrollView.setZoomScale(scale, animated: false)
            scrollView.layoutIfNeeded()
        } else {
            print("Incorrect image size")
        }
        let newContentSize = scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
    
    private func configScrollView() {
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        scrollView.isScrollEnabled = false
    }
    
    // MARK: - Methods
    
    func setImageURL(newImageURL: URL) {
        imageUrL = newImageURL
    }
}

// MARK: - Extensions

extension SingleImageViewController: UIScrollViewDelegate {
    
    // MARK: - Methods
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with: UIView?, atScale: CGFloat) {
        guard let image else { return }
        let imageHeight = image.size.height
        let imageWidth = image.size.width
        rescaleAndCenterImageInScrollView(image: image)
        scrollView.contentInset = UIEdgeInsets(top: imageHeight,
                                               left: imageWidth,
                                               bottom: imageHeight,
                                               right: imageWidth)
    }
}
