//
//  ImagesListViewTests.swift
//  ImageFeedTests
//
//  Created by Aleksey Kosichenko on 19.08.2026.
//

@testable import ImageFeed
import Foundation
import XCTest


final class ImagesListViewTests: XCTestCase {
    
    final class ImagesListViewPresenterSpy: ImagesListViewPresenterProtocol {
        var view: ImagesListViewControllerProtocol?
        var viewDidLoad = false
        var nextPhotoIsFetched = false
        
        func imagesListViewDidLoad() {
            viewDidLoad = true
        }
        
        func updateLike(photoId: String, isLike: Bool) {}
        
        func fetchPhotosNextPage() {
            nextPhotoIsFetched = true
        }
        
        func configTableViewAnimated(photos: [Photo]) {}
    }
    
    final class ImagesListViewControllerSpy: ImagesListViewControllerProtocol {
        var presenter: (any ImageFeed.ImagesListViewPresenterProtocol)?
        var photosIsUpdated = false
        var isUpdatedTableViewAnimated = false
        var tableViewIsConfigured = false
        
        func tableViewConfig() {
            tableViewIsConfigured = true
        }
        
        func updatePhotoList(photos: [Photo]) {
            photosIsUpdated = true
        }
        
        func updateTableViewAnimated(oldIndex: Int, newIndex: Int) {
            isUpdatedTableViewAnimated = true
        }
    }
    
    func testViewControllerViewDidLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        let presenter = ImagesListViewPresenterSpy()
        viewController.presenter = presenter
        _ = viewController.view
        XCTAssertTrue(presenter.viewDidLoad)
    }
    
    func testViewControllerUpdatedPhotos() {
        let presenter = ImagesListViewPresenter()
        let view = ImagesListViewControllerSpy()
        presenter.view = view
        let photos: [Photo] = []
        presenter.configTableViewAnimated(photos: photos)
        XCTAssertTrue(view.photosIsUpdated)
    }
    
    func testViewControllerUpdatedViewAnimated() {
        let presenter = ImagesListViewPresenter()
        let view = ImagesListViewControllerSpy()
        presenter.view = view
        let photos: [Photo] = []
        presenter.configTableViewAnimated(photos: photos)
        XCTAssertTrue(view.isUpdatedTableViewAnimated)
    }
    
    func testPresenterFetchNextPhoto() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        let presenter = ImagesListViewPresenterSpy()
        viewController.presenter = presenter
        _ = viewController.view
        XCTAssertTrue(presenter.nextPhotoIsFetched)
    }
    
    func testViewControllerTableViewConfigured() {
        let presenter = ImagesListViewPresenter()
        let view = ImagesListViewControllerSpy()
        presenter.view = view
        presenter.imagesListViewDidLoad()
        XCTAssertTrue(view.tableViewIsConfigured)
    }
}
