//
//  ImageFeedTests.swift
//  ImageFeedTests
//
//  Created by Aleksey Kosichenko on 11.08.2026.
//


@testable import ImageFeed
import Foundation
import XCTest

final class WebViewTests: XCTestCase {
    
    private func makeSUT() -> (
        viewController: WebViewViewController,
        presenter: WebViewPresenterSpy
    ) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "WebViewViewController"
        ) as! WebViewViewController

        let presenter = WebViewPresenterSpy()
        viewController.presenter = presenter

        return (viewController, presenter)
    }
    
    
    func testViewControllerCallsViewDidLoad() {
        // Given
        
        let (viewController, presenter) = makeSUT()
        
        // When
        
        _ = viewController.view
        
        // Then
        
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testPresenterCallsLoadRequest() {
        
        // Given
        
        let viewController = WebViewControllerSpy()
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        viewController.presenter = presenter
        presenter.view = viewController
        
        // When
        
        presenter.viewDidLoad()
        
        // Then
        
        XCTAssertTrue(viewController.requestDidLoadCalled)
    }
    
    func testProgressVisibleWhenLessThenOne() {
        
        // Given
        
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        let progress: Float = 0.6
        
        // When
        
        let shouldHideProgress = presenter.shouldHideProgress(for: progress)
        
        // Then
        
        XCTAssertFalse(shouldHideProgress)
    }
    
    func testProgressHiddenWhenOne() {
        
        // Given
        
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        let progress: Float = 1.0
        
        // When
        
        let shouldHideProgress = presenter.shouldHideProgress(for: progress)
        
        // Then
        
        XCTAssertTrue(shouldHideProgress)
    }
    
    func testAuthHelperAuthURL() {
        
        // Given
        
        let configuration = AuthConfiguration.standard
        let authHelper = AuthHelper(configuration: configuration)
        
        // When
        
        let url = authHelper.authURL()
        guard let urlString = url?.absoluteString else {
            XCTFail("Auth URL is nil")
            return
        }
        
        // Then
        
        XCTAssertTrue(urlString.contains(configuration.authURLString))
        XCTAssertTrue(urlString.contains(configuration.accessKey))
        XCTAssertTrue(urlString.contains(configuration.redirectURI))
        XCTAssertTrue(urlString.contains("code"))
        XCTAssertTrue(urlString.contains(configuration.accessScope))
    }
    
    func testCodeFromURL() {
        
        // Given
        
        let configuration = AuthConfiguration.standard
        let authHelper = AuthHelper(configuration: configuration)
        var urlComp = URLComponents(string: URLQueryItemConstants.urlComponentsPath)
        urlComp?.queryItems = [
            URLQueryItem(name: URLQueryItemConstants.code, value: "test code")
        ]
        let link = urlComp?.url
        
        // When
        
        let code = authHelper.code(from: link!)
        
        // Then
        
        XCTAssertEqual(code, "test code")
    }
}
