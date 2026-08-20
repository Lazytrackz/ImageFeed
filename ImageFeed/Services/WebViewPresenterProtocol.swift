//
//  WebViewPresenterProtocol.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 10.08.2026.
//

import Foundation

//MARK: - WebViewPresenterProtocol

public protocol WebViewPresenterProtocol {
    
    //MARK: - Properties
    
    var view: WebViewViewControllerProtocol? { get set }
    
    //MARK: - Methods
    
    func viewDidLoad()
    func didUpdateProgressValue(_ newValue: Double)
    func code(from url: URL) -> String?
}
