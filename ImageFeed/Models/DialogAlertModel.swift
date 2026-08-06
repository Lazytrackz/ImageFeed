//
//  DialogAlertModel.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 06.08.2026.
//

import Foundation

//MARK: - DialogAlertModel

struct DialogAlertModel {
    var title: String
    var message: String
    var buttonYesText: String
    var buttonNoText: String
    var completion: (Bool) -> Void
}
