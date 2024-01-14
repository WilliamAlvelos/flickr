//
//  SearchViewModel.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation
import Combine


protocol SearchContent {
    
}


final class SearchViewModel: ObservableObject {
    @Published var status: Status = .empty
    @Published var content: [Photo] = []
    @Published var groups: [Group] = []
    @Published var searchText: String = ""
    @Published var searchType: SearchType = SearchType.photos
    
    private var textPhotos: [Photo] = []
    private var tagsPhotos: [Photo] = []
    
    private var cancellable: Set<AnyCancellable> = []
    private let repository: FlickrRepositoryProtocol
    private let coordinator: SearchViewWireframe
    private var page: Page = Page(page: 0)
    
    init(repository: FlickrRepositoryProtocol, coordinator: SearchViewWireframe) {
        self.repository = repository
        self.coordinator = coordinator
    }
    
    // MARK:  Public Methods
    
    func search() {
        switch searchType {
        case .photos:
            let request = PhotosBaseRequest(text: searchText, safeSearch: .safe)
            searchPhotos(request: request, completion: { photos in
                self.textPhotos = photos
                self.content = self.textPhotos
            })
        case .tags:
            let request = PhotosBaseRequest(tags: searchText, safeSearch: .safe)
            searchPhotos(request: request, completion: { photos in
                self.tagsPhotos = photos
                self.content = self.tagsPhotos
            })
        case .groups:
            searchGroups()
        }
    }
    
    func loadNextPage() {
        
    }
    
    func presentPhoto(photo: Photo) {
        coordinator.presentPhoto(photo: photo)
    }

    func presentGroup(group: Group) {
        coordinator.presentGroup(group: group)
    }
}

// MARK:  Private Methods

extension SearchViewModel {
    private func searchPhotos(request: PhotosBaseRequest, 
                              completion: @escaping ([Photo]) -> Void) {
        
        self.status = .loading
        
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
                completion(response.photos.photo)
                self.status = .loaded
            }.store(in: &cancellable)
    }
    
    private func searchGroups() {
        self.status = .loading

        repository.searchGroupsBy(text: searchText, page: page)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.status = .error(error: error)
                }
            } receiveValue: { response in
                self.groups = response.groups.group
                self.status = .loaded
            }.store(in: &cancellable)
    }
}
