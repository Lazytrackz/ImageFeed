//
//  Constants.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 20.06.2026.
//

import Foundation

//MARK: - UrlConstants

enum UrlConstants {
    static let accessKey = "_9uIDCU8tdtAesu6yR00IVN-41AzH0ts3jCWggv2SRM"
    static let secretKey = "q3znBCBNe8zS0zpLFak5D2CT25VJw7qjhh60peKRs3Q"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURLString = "https://api.unsplash.com"
    static let profileRequest = "https://api.unsplash.com/me"
    static let profileImageRequest = "https://api.unsplash.com//users/"
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    static let tokenRequest = "https://unsplash.com/oauth/token"
    static let photosListRequest = "https://api.unsplash.com/photos"
    static let photosLikeRequest = "https://api.unsplash.com/photos/:id/like"
}
