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
        
        func updateLike(photoId: String, isLike: Bool) {
        
        }
        
        func fetchPhotosNextPage() {
            nextPhotoIsFetched = true
            
        }
        
        func configTableViewAnimated(photos: [Photo]) {
         
        }
        
       
       
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
        //given
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
    
        let presenter = ImagesListViewPresenterSpy()
        viewController.presenter = presenter
        //when
        _ = viewController.view
        //then
        XCTAssertTrue(presenter.viewDidLoad)
    }
    
    
    func testViewControllerUpdatedPhotos() {
        //given
    
        let presenter = ImagesListViewPresenter()
        let view = ImagesListViewControllerSpy()
        presenter.view = view
        
        let photos: [Photo] = []
        
      
        presenter.configTableViewAnimated(photos: photos)
        
        
        //then
        
        XCTAssertTrue(view.photosIsUpdated)
    }
    
    
    func testViewControllerUpdatedViewAnimated() {
        //given
        let presenter = ImagesListViewPresenter()
        let view = ImagesListViewControllerSpy()
        presenter.view = view
        let photos: [Photo] = []
        
        
        //when
        presenter.configTableViewAnimated(photos: photos)
        
        //then
        
        XCTAssertTrue(view.isUpdatedTableViewAnimated)
    }
    
    
    func testPresenterFetchNextPhoto() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
    
        let presenter = ImagesListViewPresenterSpy()
        viewController.presenter = presenter
       
        
        //when
        _ = viewController.view

        //then
        
        XCTAssertTrue(presenter.nextPhotoIsFetched)
        

    }
    
    
    func testViewControllerTableViewConfigured() {
        //given
        let presenter = ImagesListViewPresenter()
        let view = ImagesListViewControllerSpy()
        presenter.view = view
        
        //when
        presenter.imagesListViewDidLoad()
        
        //then
        
        XCTAssertTrue(view.tableViewIsConfigured)
    }
    

    
 
}

