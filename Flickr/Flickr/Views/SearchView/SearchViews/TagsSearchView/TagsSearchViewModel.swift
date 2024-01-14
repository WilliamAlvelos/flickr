//
//  TagsSearchViewModel.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import Foundation
import Combine

// TODO: USE GENERICS TO REDUCE THE CODE

final class TagsSearchViewModel: ObservableObject {
    @Published var status: Status = .empty
    @Published var photos: [Photo] = []
    
    private var cancellable: Set<AnyCancellable> = []
    private let repository: FlickrRepositoryProtocol
    private let coordinator: SearchViewWireframe
    
    private var page: Page = Page(page: 1)
    private var isLoadingNewPage = false

    private var currentSearch: String = ""
    
    init(repository: FlickrRepositoryProtocol, coordinator: SearchViewWireframe) {
        self.repository = repository
        self.coordinator = coordinator
    }
    
    // MARK:  Public Methods
    
    
    func search(tags: String) {
        page.reset()
        currentSearch = tags
        searchPhotos()
    }
    
    func tryAgain() {
        searchPhotos()
    }
    
    func loadMoreIfNeeded() {
        if isLoadingNewPage {
            return
        }
        isLoadingNewPage = true
        page.nextPage()
        searchPhotos()
    }
    
    // MARK:  Coordinator
    
    func presentPerson(person: String) {
        coordinator.presentUserProfile(owner: person)
    }
    
    func presentPhoto(photo: Photo) {
        coordinator.presentPhoto(photo: photo)
    }
}

// MARK:  Private Methods

extension TagsSearchViewModel {
    private func searchPhotos() {
        let request = PhotosBaseRequest(tags: currentSearch, safeSearch: .safe)
        if page.page == 1 {
            self.status = .loading
        }
        
        repository.searchPhotosBy(request: request, page: page)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.status = .error(error: error)
                }
            } receiveValue: { response in
                guard !response.photos.photo.isEmpty else {
                    self.status = .empty
                    return
                }
                
                if response.photos.page == 1 {
                    self.photos = response.photos.photo
                } else {
                    self.photos += response.photos.photo
                    self.isLoadingNewPage = false
                }
                self.status = .loaded
            }.store(in: &cancellable)
    }
}
