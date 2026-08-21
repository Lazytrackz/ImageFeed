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
    
    final class WebViewPresenterSpy: WebViewPresenterProtocol {
        var viewDidLoadCalled: Bool = false
        var view: WebViewViewControllerProtocol?
        
        func viewDidLoad() {
            viewDidLoadCalled = true
        }
        
        func didUpdateProgressValue(_ newValue: Double) {}
        
        func code(from url: URL) -> String? {
            return nil
        }
    }
    
    final class WebViewControllerSpy: WebViewViewControllerProtocol {
        var presenter: WebViewPresenterProtocol?
        var requestDidLoadCalled: Bool = false
    
        func load(request: URLRequest) {
            requestDidLoadCalled = true
        }
        
        func setProgressValue(_ newValue: Float) {}
        func setProgressHidden(_ isHidden: Bool) {}
    }

    func testViewControllerCallsViewDidLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        let presenter = WebViewPresenterSpy()
        viewController.presenter = presenter
        _ = viewController.view
        XCTAssertTrue(presenter.viewDidLoadCalled) //behaviour verification
    }
    
    func testPresenterCallsLoadRequest() {
        let viewController = WebViewControllerSpy()
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.viewDidLoad()
        XCTAssertTrue(viewController.requestDidLoadCalled)
    }
    
    func testProgressVisibleWhenLessThenOne() {
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        let progress: Float = 0.6
        let shouldHideProgress = presenter.shouldHideProgress(for: progress)
        XCTAssertFalse(shouldHideProgress)
    }
    
    func testProgressHiddenWhenOne() {
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        let progress: Float = 1.0
        let shouldHideProgress = presenter.shouldHideProgress(for: progress)
        XCTAssertTrue(shouldHideProgress)
    }
    
    func testAuthHelperAuthURL() {
        let configuration = AuthConfiguration.standard
        let authHelper = AuthHelper(configuration: configuration)
        let url = authHelper.authURL()
        guard let urlString = url?.absoluteString else {
            XCTFail("Auth URL is nil")
            return
        }
        XCTAssertTrue(urlString.contains(configuration.authURLString))
        XCTAssertTrue(urlString.contains(configuration.accessKey))
        XCTAssertTrue(urlString.contains(configuration.redirectURI))
        XCTAssertTrue(urlString.contains("code"))
        XCTAssertTrue(urlString.contains(configuration.accessScope))
    }
    
    func testCodeFromURL() {
        let configuration = AuthConfiguration.standard
        let authHelper = AuthHelper(configuration: configuration)
        var urlComp = URLComponents(string: URLQueryItemConstants.urlComponentsPath)
        urlComp?.queryItems = [
            URLQueryItem(name: URLQueryItemConstants.code, value: "test code")
        ]
        let link = urlComp?.url
        let code = authHelper.code(from: link!)
        XCTAssertEqual(code, "test code")
    }
}
