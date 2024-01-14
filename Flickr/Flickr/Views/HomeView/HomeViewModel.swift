//
//  HomeViewModel.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var status: Status = .loading
    @Published var photos: [Photo] = []
    @Published var searchText = "yorkshire"
    
    private let repository: FlickrRepositoryProtocol
    private var cancellable: Set<AnyCancellable> = []
    private var page: Page = Page(page: 0)
    private var coordinator: HomeViewWireframe
    
    init(repository: FlickrRepositoryProtocol, coordinator: HomeViewWireframe) {
        self.repository = repository
        self.coordinator = coordinator
    }
    
    // MARK:  Public Methods
    
    func loadMoreIfNeeded(item: Photo) {
        guard let itemIndex = self.photos.lastIndex(where: { $0.id == item.id }) else { return }
        let distanceToFetch = 10

        if itemIndex.distance(to: self.photos.endIndex) < distanceToFetch {
            page.nextPage()
            searchPhotos()
        }
    }

    func loadFirstPage() {
        page.reset()
        searchPhotos()
    }
    
    func presentPhoto(photo: Photo) {
        coordinator.presentPhoto(photo: photo)
    }
    
    func presentUserProfile(owner: String) {
        coordinator.presentUserProfile(owner: owner)
    }
}

// MARK:  Private Methods

extension HomeViewModel {
    private func searchPhotos() {
        let request = PhotosBaseRequest(text: searchText, sort: .relevance, safeSearch: .safe)

        repository.searchPhotosBy(request: request, page: page)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.status = .error(error: error)
                }
            } receiveValue: { photos in
                guard !photos.photos.photo.isEmpty else {
                    self.status = .empty
                    return
                }
                
                if photos.photos.page == 1 {
                    self.photos = photos.photos.photo
                } else {
                    self.photos += photos.photos.photo
                }
                self.status = .loaded
            }.store(in: &cancellable)
    }
}
