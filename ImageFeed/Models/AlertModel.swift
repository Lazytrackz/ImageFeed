//
//  AlertModel.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 14.07.2026.
//

import Foundation

//MARK: - AlertModel

struct AlertModel {
    var title: String
    var message: String
    var buttonText: String
    var completion: () -> Void
}
