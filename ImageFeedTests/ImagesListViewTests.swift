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
    
    
    private func makeSUT() -> (
        viewController: ImagesListViewController,
        presenter: ImagesListViewPresenterSpy
    ) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "ImagesListViewController"
        ) as! ImagesListViewController

        let presenter = ImagesListViewPresenterSpy()
        viewController.presenter = presenter

        return (viewController, presenter)
    }
        
    func testViewControllerViewDidLoad() {
        
        // Given
        
        let (viewController, presenter) = makeSUT()
        
        // When
        
        _ = viewController.view
        
        // Then
        
        XCTAssertTrue(presenter.viewDidLoad)
    }
    
    func testViewControllerUpdatedPhotos() {
        
        // Given
        
        let presenter = ImagesListViewPresenter()
        let view = ImagesListViewControllerSpy()
        presenter.view = view
        let photos: [Photo] = []
        
        // When
        
        presenter.configTableViewAnimated(photos: photos)
        
        // Then
        
        XCTAssertTrue(view.photosIsUpdated)
    }
    
    func testViewControllerUpdatedViewAnimated() {
        
        // Given
        
        let presenter = ImagesListViewPresenter()
        let view = ImagesListViewControllerSpy()
        presenter.view = view
        let photos: [Photo] = []
        
        // When
        
        presenter.configTableViewAnimated(photos: photos)
        
        // Then
        
        XCTAssertTrue(view.isUpdatedTableViewAnimated)
    }
    
    func testPresenterFetchNextPhoto() {
        
        // Given
        
        let (viewController, presenter) = makeSUT()
        
        // When
        
        _ = viewController.view
        
        // Then
        
        XCTAssertTrue(presenter.nextPhotoIsFetched)
    }
    
    func testViewControllerTableViewConfigured() {
        
        // Given
        
        let presenter = ImagesListViewPresenter()
        let view = ImagesListViewControllerSpy()
        presenter.view = view
        
        // When
        
        presenter.imagesListViewDidLoad()
        
        // Then
        
        XCTAssertTrue(view.tableViewIsConfigured)
    }
}
