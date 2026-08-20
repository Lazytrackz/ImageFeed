//
//  WebViewPresenter.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 10.08.2026.
//

import Foundation


final class WebViewPresenter: WebViewPresenterProtocol {
   
    weak var view: WebViewViewControllerProtocol?
    var authHelper: AuthHelperProtocol
    
    init(authHelper: AuthHelperProtocol) {
        self.authHelper = authHelper
    }
    
    
    
    func viewDidLoad() {
        /*guard var urlComponents = URLComponents(string: UrlConstants.unsplashAuthorizeURLString) else {
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name: URLQueryItemConstants.clientId, value: UrlConstants.accessKey),
            URLQueryItem(name: URLQueryItemConstants.redirectUri, value: UrlConstants.redirectURI),
            URLQueryItem(name: URLQueryItemConstants.responseType, value: URLQueryItemConstants.code),
            URLQueryItem(name: URLQueryItemConstants.scope, value: UrlConstants.accessScope)
        ]
        guard let url = urlComponents.url else {
            print("Invalid url")
            return
        }
        let request = URLRequest(url: url)*/
        
        guard let request = authHelper.authRequest() else { return }
        didUpdateProgressValue(0)
        view?.load(request: request)
        
    }
    
    
    func didUpdateProgressValue(_ newValue: Double) {
        let newProgressValue = Float(newValue)
        view?.setProgressValue(newProgressValue)
        
        let shouldHideProgress = shouldHideProgress(for: newProgressValue)
        view?.setProgressHidden(shouldHideProgress)
    }
    
    func shouldHideProgress(for value: Float) -> Bool {
        abs(value - 1.0) <= 0.0001
    }
    
    
    func code(from url: URL) -> String? {
       /* if
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == URLQueryItemConstants.urlComponentsPath,
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == URLQueryItemConstants.code })
        {
            return codeItem.value
            
        } else {
            return nil
        }*/
        
        authHelper.code(from: url)
        
    }
    
    
}
