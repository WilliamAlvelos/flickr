//
//  FlickrRepository.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation
import Combine

protocol FlickrRepositoryProtocol {
    func fetchPhotosBy(userId: String, safeSearch: SafeSearch, page: Page) -> AnyPublisher<PhotosBaseRequest<Photos>, Error>
    func searchPhotosBy(text: String, safeSearch: SafeSearch, page: Page) -> AnyPublisher<PhotosBaseRequest<Photos>, Error>
    
    func findUserBy(userName: String) -> AnyPublisher<UserBaseRequest<User>, Error>
    func fetchPersonInfo(userId: String) -> AnyPublisher<PersonBaseRequest<Person>, Error>

}

final class FlickrRepository: FlickrRepositoryProtocol {
    private let apiClient = URLSessionAPIClient()

    // TODO:  Move safe search and page to optional
    func searchPhotosBy(text: String, safeSearch: SafeSearch, page: Page) -> AnyPublisher<PhotosBaseRequest<Photos>, Error> {
        apiClient.request(EndPoints.search(text: text, safeSearch: safeSearch, page: page).builder())
    }
    
    func findUserBy(userName: String) -> AnyPublisher<UserBaseRequest<User>, Error> {
        apiClient.request(EndPoints.userSearch(userName: userName).builder())
    }

    func fetchPhotosBy(userId: String, safeSearch: SafeSearch, page: Page) -> AnyPublisher<PhotosBaseRequest<Photos>, Error> {
        apiClient.request(EndPoints.photos(userId: userId, safeSearch: safeSearch, page: page).builder())
    }
    
    func fetchPersonInfo(userId: String) -> AnyPublisher<PersonBaseRequest<Person>, Error> {
        apiClient.request(EndPoints.personInfo(userId: userId).builder())
    }
}
 
