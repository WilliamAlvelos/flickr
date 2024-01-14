//
//  FlickrRepository.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation
import Combine

protocol FlickrRepositoryProtocol {
    func searchPhotosBy(request: PhotosBaseRequest, page: Page) -> AnyPublisher<PhotosBaseResponse<Photos>, Error>

//    func fetchPhotosBy(userId: String, safeSearch: SafeSearch, page: Page) -> AnyPublisher<PhotosBaseResponse<Photos>, Error>
//    func searchPhotosBy(text: String, safeSearch: SafeSearch, page: Page) -> AnyPublisher<PhotosBaseResponse<Photos>, Error>
//    func searchPhotosBy(tags: String, safeSearch: SafeSearch, page: Page) -> AnyPublisher<PhotosBaseResponse<Photos>, Error>
    
    func searchGroupsBy(text: String, page: Page) -> AnyPublisher<GroupBaseResponse<Groups>, Error>

    
    func findUserBy(userName: String) -> AnyPublisher<UserBaseResponse<User>, Error>
    func fetchPersonInfo(userId: String) -> AnyPublisher<PersonBaseResponse<Person>, Error>
}

final class FlickrRepository: FlickrRepositoryProtocol {
    private let apiClient = URLSessionAPIClient()

    func searchPhotosBy(request: PhotosBaseRequest, page: Page) -> AnyPublisher<PhotosBaseResponse<Photos>, Error> {
        apiClient.request(EndPoints.searchPhotos(request: request, page: page).builder())
    }
//    
//    func searchPhotosBy(tags: String, safeSearch: SafeSearch, page: Page) -> AnyPublisher<PhotosBaseResponse<Photos>, Error> {
//        apiClient.request(EndPoints.search(text: tags, safeSearch: safeSearch, page: page).builder())
//    }
    
    func searchGroupsBy(text: String, page: Page) -> AnyPublisher<GroupBaseResponse<Groups>, Error> {
        apiClient.request(EndPoints.groupsSearch(text: text, page: page).builder())
    }
    
    func findUserBy(userName: String) -> AnyPublisher<UserBaseResponse<User>, Error> {
        apiClient.request(EndPoints.userSearch(userName: userName).builder())
    }

//    func fetchPhotosBy(userId: String, safeSearch: SafeSearch, page: Page) -> AnyPublisher<PhotosBaseResponse<Photos>, Error> {
//        apiClient.request(EndPoints.photos(userId: userId, safeSearch: safeSearch, page: page).builder())
//    }
    
    func fetchPersonInfo(userId: String) -> AnyPublisher<PersonBaseResponse<Person>, Error> {
        apiClient.request(EndPoints.personInfo(userId: userId).builder())
    }
}
 
