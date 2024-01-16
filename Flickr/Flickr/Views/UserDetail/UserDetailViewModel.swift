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
    private var cancellables: Set<AnyCancellable> = []
    private var page: Page = Page(page: 1)
    private let userId: String
    
    init(repository: FlickrRepositoryProtocol, userId: String) {
        self.repository = repository
        self.userId = userId
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

// MARK:  Public Methods
extension UserDetailViewModel {
    func fetchPhotosAndUserDetails() {
        let request = PhotosBaseRequest(userId: userId, sort: .relevance, safeSearch: .safe)
        
        repository.searchPhotosBy(request: request, page: page)
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
                self.status = .loaded
            }.store(in: &cancellables)
    }
}
