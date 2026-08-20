//
//  WebViewViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 10.08.2026.
//

import Foundation

//MARK: - WebViewViewControllerProtocol

public protocol WebViewViewControllerProtocol: AnyObject {
    
    //MARK: - Properties
    
    var presenter: WebViewPresenterProtocol? { get set }
    
    //MARK: - Methods
    
    func load(request: URLRequest)
    func setProgressValue(_ newValue: Float)
    func setProgressHidden(_ isHidden: Bool)
    
}
