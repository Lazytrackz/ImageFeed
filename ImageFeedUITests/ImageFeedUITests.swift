//
//  ImageFeedUITests.swift
//  ImageFeedUITests
//
//  Created by Aleksey Kosichenko on 18.08.2026.
//

import XCTest

final class ImageFeedUITests: XCTestCase {
    
    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app.launch()
        
    }
    
    func testAuth() throws {
        
        app.buttons["AuthButton"].tap()
        let webView = app.webViews["WebView"]
        XCTAssertTrue(webView.waitForExistence(timeout: 5))
        
        
        let loginTextField = webView.textFields["Email address"]
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 5))
        
        loginTextField.tap()
        loginTextField.typeText("lazytrackz@gmail.com")
        webView.swipeUp()
        
        let passwordTextField = webView.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 5))
        
        passwordTextField.tap()
        passwordTextField.typeText("Lamplighter14!")
        app.keyboards.buttons["Go"].tap()
        
        
        let table = app.tables
        let cell = table.children(matching: .cell).element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
        
        
    }
    
    func testFeed() throws {
        
        sleep(5)
        
        let tables = app.tables
        let cell = tables.children(matching: .cell).element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
        cell.swipeUp()
        
        
        
        let cellDidLike = tables.children(matching: .cell).element(boundBy: 1)
        XCTAssertTrue(cellDidLike.waitForExistence(timeout: 5))
        
        cellDidLike.buttons["LikeButton"].tap()
        sleep(3)
        cellDidLike.buttons["LikeButton"].tap()
        sleep(3)
        
        cellDidLike.tap()
        
        sleep(3)
        
        let cellImage = app.scrollViews.images.element(boundBy: 0)
        cellImage.pinch(withScale: 3, velocity: 1)
        cellImage.pinch(withScale: 0.5, velocity: -1)
        
        let backButton = app.buttons["BackButton"]
        backButton.tap()
        
    }
    
    
    func testProfile() throws {
        
        sleep(5)
        let button = app.tabBars.buttons.images["tab_profile_active"]
        button.tap()
        
        
        sleep(3)
        
        XCTAssertTrue(app.staticTexts["Alex K"].exists)
        XCTAssertTrue(app.staticTexts["@lazytrackz"].exists)
        
        app.buttons["LogoutButton"].tap()
        app.alerts["LogoutDialogAlert"].scrollViews.otherElements.buttons["Да"].tap()
        
        let authButton = app.buttons["AuthButton"]
        XCTAssertTrue(authButton.waitForExistence(timeout: 5))
    }
}
