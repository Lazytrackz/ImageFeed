//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 12.07.2026.
//

import Foundation

//MARK: - ProfileImageService

final class ProfileImageService {
    
    //MARK: - private properties
    
    private(set) var avatarURL: String?
    private var task: URLSessionTask?
    private init() {}
    
    //MARK: - properties
    
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    
    
    //MARK: - private methods
    
    private func makeProfileImageRequest(token: String, username: String) -> URLRequest? {
        guard let url = URL(string: UrlConstants.profileImageRequest + (username)) else {
            print("Unable to make request")
            return nil
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        return request
    }
    
    //MARK: - methods
    
    func fetchProfileImageURL(username: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        task?.cancel()
        guard let token = OAuth2TokenStorage().token else {
            print("Token not found")
            return
        }
        guard let request = makeProfileImageRequest(token: token, username: username) else {
            completion(.failure(ProfileServiceError.invalidRequest))
            return
        }
        let task = URLSession.shared.objectTask(for: request, completion: {(result: Result<UserResult, Error>) in
            switch result {
            case .success(let data):
                self.avatarURL = data.profileImage.small
                completion(.success(data.profileImage.small))
                print(data.profileImage.small)
                
                NotificationCenter.default
                    .post(
                        name: ProfileImageService.didChangeNotification,
                        object: self,
                        userInfo: ["URL": data.profileImage.small])
            case .failure(let error):
                print("Request error: \(error.localizedDescription)")
                completion(.failure(error))
            }
            self.task = nil
        })
        self.task = task
        task.resume()
    }
}
