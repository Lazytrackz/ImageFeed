//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 24.06.2026.
//

import Foundation


enum AuthServiceError: Error {
    case invalidRequest
}


// MARK: - OOAuth2Service

final class OAuth2Service {
    
    // MARK: - static properties
    
    static let shared = OAuth2Service()
    
    // MARK: - private properties
    
    private var tokenStorage: OAuth2TokenStorage?
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private var lastCode: String?
    private init() {}
    
    // MARK: - private methods
    
    private func makeTokenRequest(code: String) -> URLRequest? {
        guard var url = URLComponents(string: UrlConstants.tokenRequest) else {
            print("Unable to make request")
            return nil
        }
        url.queryItems = [
            URLQueryItem(name: URLQueryItemConstants.clientId, value: UrlConstants.accessKey),
            URLQueryItem(name: URLQueryItemConstants.clientSecret, value: UrlConstants.secretKey),
            URLQueryItem(name: URLQueryItemConstants.redirectUri, value: UrlConstants.redirectURI),
            URLQueryItem(name: URLQueryItemConstants.code, value: code),
            URLQueryItem(name: URLQueryItemConstants.grandType, value: URLQueryItemConstants.authorizationCode)
        ]
        guard let token = url.url else {
            print("Loading url failed")
            return nil
        }
        var request = URLRequest(url: token)
        request.httpMethod = "POST"
        return request
    }
    
    // MARK: - methods
    
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        guard lastCode != code else {
            completion(.failure(AuthServiceError.invalidRequest))
            return
        }
        task?.cancel()
        
        lastCode = code
 
        guard let request = makeTokenRequest(code: code) else {
            completion(.failure(AuthServiceError.invalidRequest))
            return
        }
        let task = URLSession.shared.objectTask(for: request, completion: {(result: Result<OAuthTokenResponseBody, Error>) in
            switch result {
            case .success(let data):
                if code == self.lastCode {
                    completion(.success(data.accessToken))
                    if !data.accessToken.isEmpty {
                        self.tokenStorage = OAuth2TokenStorage()
                        self.tokenStorage?.token = data.accessToken
                    }
                } else {
                    completion(.failure(AuthServiceError.invalidRequest))
                    return
                }
                self.task = nil
                self.lastCode = nil
            case .failure(let error):
                print("Request error: \(error.localizedDescription)")
                completion(.failure(error))
                
                self.task = nil
                self.lastCode = nil
            }
        })
        self.task = task
        task.resume()
    }
}
