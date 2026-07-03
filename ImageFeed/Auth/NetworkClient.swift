//
//  NetworkClient.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 28.06.2026.
//

import Foundation

// MARK: - NetworkClient

struct NetworkClient: NetworkRouting {
    
    // MARK: - constants
    
    private enum NetworkError: Error {
        case codeError
    }
    
    // MARK: - Methods
    
    func fetch(request: URLRequest?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = request else { return }
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error {
                    completion(.failure(error))
                    print(error)
                    return
                }
                if let response = response as? HTTPURLResponse,
                   response.statusCode < 200 || response.statusCode >= 300 {
                    completion(.failure(NetworkError.codeError))
                    guard let data = data else { return }
                    print(String(data: data, encoding: .utf8) ?? data)
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
            task.resume()
       
    }
}
