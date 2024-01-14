//
//  FakeFlickrRepository.swift
//  FlickrTests
//
//  Created by William de Alvelos on 14/01/2024.
//

import Foundation
import Combine
@testable import Flickr

class FakeFlickrRepository: FlickrRepositoryProtocol {
    var shouldThrowError = false
    var mockedPhotos: [Photo] = []
    var mockedError: Error = NSError(domain: "MockError", code: 500, userInfo: nil)

    var users: [UserBaseRequest<User>] = []
    var persons: [PersonBaseRequest<Person>] = []
    
    func fetchPhotosBy(userId: String, safeSearch: SafeSearch, page: Page) -> AnyPublisher<PhotosBaseRequest<Photos>, Error> {
        if shouldThrowError {
            return Fail(error: mockedError).eraseToAnyPublisher()
        } else {
            let fakePhotos = PhotosBaseRequest(photos: Photos(total: 1, page: 0, pages: 1, perpage: 10, photo: mockedPhotos),
                                               stat: .ok)
            return Just(fakePhotos).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }

    func searchPhotosBy(text: String, safeSearch: SafeSearch, page: Page) -> AnyPublisher<PhotosBaseRequest<Photos>, Error> {
        if shouldThrowError {
            return Fail(error: mockedError).eraseToAnyPublisher()
        } else {
            let fakePhotos = PhotosBaseRequest(photos: Photos(total: 1, page: 0, pages: 1, perpage: 10, photo: mockedPhotos),
                                               stat: .ok)
            return Just(fakePhotos).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }

    func findUserBy(userName: String) -> AnyPublisher<UserBaseRequest<User>, Error> {
        if let user = users.first {
            return Just(user)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "MockError", code: 404, userInfo: nil))
                .eraseToAnyPublisher()
        }
    }

    func fetchPersonInfo(userId: String) -> AnyPublisher<PersonBaseRequest<Person>, Error> {
        if let person = persons.first {
            return Just(person)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "MockError", code: 404, userInfo: nil))
                .eraseToAnyPublisher()
        }
    }
}
