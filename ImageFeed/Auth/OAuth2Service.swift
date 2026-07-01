//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 24.06.2026.
//

import Foundation

// MARK: - OOAuth2Service

final class OAuth2Service {
    
    // MARK: - static properties
    
    static let shared = OAuth2Service()
    
    // MARK: - private properties
    
    private let networkClient = NetworkClient()
    private let jsonDecoder = JSONDecoder()
    private init() {}
    
    // MARK: - private methods
    
    private func makeTokenRequest(code: String) -> URLRequest? {
        guard var url = URLComponents(string: "https://unsplash.com/oauth/token") else {
            print("Unable to make request")
            return nil
        }
        url.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
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
    
    func fetchOAuthToken (code: String, handler: @escaping (Result<AccessToken, Error>) -> Void) {
        networkClient.fetch(request: makeTokenRequest(code: code), handler: {result in
            switch result {
            case .success(let data):
                do {
                    let token = try self.jsonDecoder.decode(AccessToken.self, from: data)
                    handler(.success(token))
                } catch {
                    handler(.failure(error))
                    print(error)
                }
            case .failure(let error):
                handler(.failure(error))
                print(error)
            }
        })
    }
}
