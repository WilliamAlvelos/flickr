//
//  UserDetailViewModel.swift
//  Flickr
//
//  Created by William de Alvelos on 13/01/2024.
//

import Foundation
import Combine

class UserDetailViewModel: ObservableObject {
    
    @Published var status: Status = .loading
    @Published var photos: [Photo] = []
    @Published var person: Person? = nil
    
    private let repository: FlickrRepositoryProtocol
    private var cancellable: Set<AnyCancellable> = []
    private var page: Page = Page(page: 0)
    private let userId: String
    
    init(repository: FlickrRepositoryProtocol, userId: String) {
        self.repository = repository
        self.userId = userId
    }
    
}

extension UserDetailViewModel {
    func fetchPhotosAndUserDetails() {
        repository.fetchPhotosBy(userId: userId, safeSearch: .safe, page: Page(page: 0))
            .zip(repository.fetchPersonInfo(userId: userId))
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.status = .error(error: error)
                }
            } receiveValue: { photosResponse, personResponse in
                self.person = personResponse.person
                
                guard !photosResponse.photos.photo.isEmpty else {
                    self.status = .empty
                    return
                }
                
                self.photos = photosResponse.photos.photo
            }.store(in: &cancellable)
    }
}
