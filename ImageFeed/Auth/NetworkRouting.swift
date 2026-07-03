//
//  NetworkRouting.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 28.06.2026.
//

import Foundation

// MARK: - NetworkRouting

protocol NetworkRouting {
    
    // MARK: - methods
    
    func fetch(request: URLRequest?, completion: @escaping (Result<Data, Error>) -> Void)
}

