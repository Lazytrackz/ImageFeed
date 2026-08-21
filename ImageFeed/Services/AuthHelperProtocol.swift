//
//  AuthHelperProtocol.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 11.08.2026.
//

import Foundation

//MARK: - AuthHelperProtocol

protocol AuthHelperProtocol {
    func authRequest() -> URLRequest?
    func code(from url: URL) -> String?
}
