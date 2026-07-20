//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 11.07.2026.
//

import Foundation

//MARK: - ProfileServiceError

enum ProfileServiceError: Error {
    case invalidRequest
}

//MARK: - ProfileService

final class ProfileService {
    
    //MARK: - private properties
    
    private var task: URLSessionTask?
    private(set) var profile: Profile?
    private init() {}
    
    //MARK: - properties
    
    static let shared = ProfileService()
    
    //MARK: - private methods
    
    private func makeProfileRequest(token: String) -> URLRequest? {
        guard let url = URL(string: UrlConstants.profileRequest) else {
            print("Unable to make request")
            return nil
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        return request
    }
    
    //MARK: - methods
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        task?.cancel()
        guard let request = makeProfileRequest(token: token) else {
            completion(.failure(ProfileServiceError.invalidRequest))
            return
        }
        let task = URLSession.shared.objectTask(for: request, completion: {(result: Result<ProfileResult, Error>) in
            switch result {
            case .success(let data):
                let profile = Profile(
                    username: data.username,
                    name: data.firstName + " " + data.lastName,
                    loginName: "@\(data.username)",
                    bio: data.bio)
                completion(.success(profile))
                self.profile = profile
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
