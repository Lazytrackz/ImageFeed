//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Aleksey Kosichenko on 24.07.2026.
//

import Foundation
import CoreGraphics

//MARK: - Errors

enum ImageListServiceError: Error {
    case invalidRequest
    case photoNotFound
}

//MARK: - ImagesListService

final class ImagesListService {
    
    //MARK: - Properties
    
    private var lastLoadedPage: Int?
    private var nextPage: Int?
    private(set) var photos: [Photo] = []
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    private var task: URLSessionTask?
    static let shared = ImagesListService()
    let dateFormatter = ISO8601DateFormatter()
    
    private init() {}
    
    //MARK: - Public methods
    
    func changeLike(photoId: String, isLike: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        task?.cancel()
        guard let token = OAuth2TokenStorage().token else {
            completion(.failure(ImageListServiceError.invalidRequest))
            print("Token not found")
            return
        }
        guard let request = changeLikeRequest(token: token, isLike: isLike, photoId: photoId) else {
            completion(.failure(ImageListServiceError.invalidRequest))
            print("Incorrect request")
            return
        }
        let task = URLSession.shared.data(for: request, completion: {[self](result: Result<Data, Error>) in
            switch result {
            case .success:
                if let index = self.photos.firstIndex(where: { $0.id == photoId }) {
                    let photo = self.photos[index]
                    let newPhoto = Photo(
                        id: photo.id,
                        size: photo.size,
                        createdAt: photo.createdAt,
                        welcomeDescription: photo.welcomeDescription,
                        thumbImageURL: photo.thumbImageURL,
                        largeImageURL: photo.largeImageURL,
                        isLiked: !photo.isLiked
                    )
                    self.photos[index] = newPhoto
                    completion(.success(Void()))
                } else {
                    completion(.failure(ImageListServiceError.photoNotFound))
                    print("Index not found")
                    return
                }
                self.task = nil
                
            case .failure(let error):
                completion(.failure(error))
                print(error)
                self.task = nil
            }
        })
        self.task = task
        task.resume()
    }
    
    func fetchPhotosNextPage() {
        task?.cancel()
        nextPage = (lastLoadedPage ?? 0) + 1
        guard let token = OAuth2TokenStorage().token else {
            print("Token not found")
            return
        }
        guard let  nextPage else {
            print("Page not found")
            return
        }
        guard let request = makeListPhotosRequest(token: token, pageNumber: nextPage) else {
            print(ImageListServiceError.invalidRequest)
            return
        }
        let task = URLSession.shared.objectTask(for: request, completion: { [self](result: Result<[PhotoResult], Error>) in
            switch result {
            case .success(let photos):
                let lastLoadedPage = self.lastLoadedPage ?? 0
                if nextPage - lastLoadedPage == 1 {
                    let newPhotos = photos.map { photo in
                        Photo(id: photo.id,
                              size: CGSize(width: photo.width, height: photo.height),
                              createdAt: self.dateFormatter.date(from: photo.createdAt ?? "Unknown date"),
                              welcomeDescription: photo.description ?? "No description",
                              thumbImageURL: photo.urls.thumb, largeImageURL: photo.urls.full, isLiked: photo.isLiked)
                    }
                    self.photos.append(contentsOf: newPhotos)
                    NotificationCenter.default
                        .post(
                            name: ImagesListService.didChangeNotification,
                            object: self,
                            userInfo: ["URL": self.photos.count])
                    self.lastLoadedPage = nextPage
                }
                self.task = nil
            case .failure(let error):
                print("Request error: \(error.localizedDescription)")
                self.task = nil
            }
        })
        self.task = task
        task.resume()
    }
    
    func clearPhotos() {
        photos.removeAll()
    }
    
    //MARK: - Private methods
    
    private func makeListPhotosRequest(token: String, pageNumber: Int) -> URLRequest? {
        guard var url = URLComponents(string: UrlConstants.photosListRequest) else {
            print("Unable to make request")
            return nil
        }
        url.queryItems = [
            URLQueryItem(name: URLQueryItemConstants.pageNumberToRetrieve, value: String(pageNumber)),
            URLQueryItem(name: URLQueryItemConstants.numberOfItemsPerPage, value: "10"),
        ]
        guard let finalUrl = url.url else {
            print("Loading url failed")
            return nil
        }
        var request = URLRequest(url: finalUrl)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        return request
    }
    
    private func changeLikeRequest(token: String, isLike: Bool, photoId: String) -> URLRequest? {
        guard let url = URL(string: UrlConstants.photosListRequest + "/\(photoId)/like") else {print("Unable to make request")
            return nil
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = isLike == true ? "POST" : "DELETE"
        return request
    }
}
