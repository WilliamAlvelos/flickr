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
    var mockedGroups: [Group] = []
    var mockedPerson: Person?
    var mockedUser: User?

    var mockedError: Error = NSError(domain: "MockError", code: 500, userInfo: nil)
    
    func searchPhotosBy(request: PhotosBaseRequest, page: Page) -> AnyPublisher<PhotosBaseResponse<Photos>, Error> {
        if shouldThrowError {
            return Fail(error: mockedError).eraseToAnyPublisher()
        } else {
            let fakePhotos = PhotosBaseResponse(photos: Photos(total: 1, page: 0, pages: 1, perpage: 10, photo: mockedPhotos),
                                               stat: .ok)
            return Just(fakePhotos).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }
    
    func searchGroupsBy(text: String, page: Page) -> AnyPublisher<GroupBaseResponse<Groups>, Error> {
        if shouldThrowError {
            return Fail(error: mockedError).eraseToAnyPublisher()
        } else {
            let fakeGroups = GroupBaseResponse(groups: Groups(total: 1, page: 0, pages: 1, perpage: 10, group: mockedGroups),
                                               stat: .ok)
            return Just(fakeGroups).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }
    
    func findUserBy(userName: String) -> AnyPublisher<UserBaseResponse<User>, Error> {
        if shouldThrowError {
            return Fail(error: mockedError).eraseToAnyPublisher()
        } else {
            guard let fakeUser = mockedUser else {
                return Fail(error: NSError(domain: "mocked was nil", code: -1)).eraseToAnyPublisher()
            }
            
            let response = UserBaseResponse<User>(user: fakeUser, stat: .ok)
            return Just(response).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }

    func fetchPersonInfo(userId: String) -> AnyPublisher<PersonBaseResponse<Person>, Error> {
        if shouldThrowError {
            return Fail(error: mockedError).eraseToAnyPublisher()
        } else {
            guard let fakePerson = mockedPerson else {
                return Fail(error: NSError(domain: "mocked was nil", code: -1)).eraseToAnyPublisher()
            }
            
            let response = PersonBaseResponse<Person>(person: fakePerson, stat: .ok)
            return Just(response).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }
}
