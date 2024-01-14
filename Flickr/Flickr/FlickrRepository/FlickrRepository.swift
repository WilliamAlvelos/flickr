//
//  FlickrRepository.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Combine

protocol FlickrRepositoryProtocol {
    func searchPhotosBy(request: PhotosBaseRequest, page: Page) -> AnyPublisher<PhotosBaseResponse<Photos>, Error>
    func searchGroupsBy(text: String, page: Page) -> AnyPublisher<GroupBaseResponse<Groups>, Error>
    func searchUserBy(userName: String, page: Page) -> AnyPublisher<PeopleBaseResponse<PeoplePage>, Error>

    func fetchUserBy(userName: String) -> AnyPublisher<UserBaseResponse<User>, Error>
    func fetchPersonInfo(userId: String) -> AnyPublisher<PersonBaseResponse<Person>, Error>
}

final class FlickrRepository: FlickrRepositoryProtocol {
    private let apiClient = URLSessionAPIClient()
    
    func searchPhotosBy(request: PhotosBaseRequest, page: Page) -> AnyPublisher<PhotosBaseResponse<Photos>, Error> {
        apiClient.request(EndPoints.searchPhotos(request: request, page: page).builder())
    }
    
    func searchGroupsBy(text: String, page: Page) -> AnyPublisher<GroupBaseResponse<Groups>, Error> {
        apiClient.request(EndPoints.searchGroups(text: text, page: page).builder())
    }
    
    func searchUserBy(userName: String, page: Page) -> AnyPublisher<PeopleBaseResponse<PeoplePage>, Error> {
        apiClient.request(EndPoints.searchUser(userName: userName, page: page).builder())
    }
    
    func fetchUserBy(userName: String) -> AnyPublisher<UserBaseResponse<User>, Error> {
        apiClient.request(EndPoints.fetchUser(userName: userName).builder())
    }
    
    func fetchPersonInfo(userId: String) -> AnyPublisher<PersonBaseResponse<Person>, Error> {
        apiClient.request(EndPoints.personInfo(userId: userId).builder())
    }
}
