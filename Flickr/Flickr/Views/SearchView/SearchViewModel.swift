//
//  SearchViewModel.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    @Published var status: Status = .empty
    
    @Published var photos: [Photo] = []
    @Published var people: [SearchPerson] = []
    @Published var groups: [Group] = []
    
    @Published var searchText: String = ""
    @Published var searchType: SearchType = SearchType.tags
    
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
        case .tags:
            searchPhotos()
        case .user:
            searchUsers()
        case .groups:
            searchGroups()
        }
    }
    
    func loadNextPage() {
        
    }
    
    // MARK:  Coordinator
    
    func presentPhoto(photo: Photo) {
        coordinator.presentPhoto(photo: photo)
    }

    func presentGroup(group: Group) {
        coordinator.presentGroup(group: group)
    }
    
    func presentPerson(person: String) {
        coordinator.presentUserProfile(owner: person)
    }
}

// MARK:  Private Methods

extension SearchViewModel {
    private func searchPhotos() {
        let request = PhotosBaseRequest(tags: searchText, safeSearch: .safe)
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
                self.photos = response.photos.photo
                self.status = .loaded
            }.store(in: &cancellable)
    }
    
    private func searchUsers() {
        self.status = .loading

        repository.searchUserBy(userName: searchText, page: page)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.status = .error(error: error)
                }
            } receiveValue: { response in
                self.people = response.people.person
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
