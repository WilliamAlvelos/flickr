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
    private var cancellables: Set<AnyCancellable> = []
    private var page: Page = Page(page: 1)
    private var coordinator: HomeViewWireframe
    private var isLoadingNewPage: Bool = false
    
    init(repository: FlickrRepositoryProtocol, coordinator: HomeViewWireframe) {
        self.repository = repository
        self.coordinator = coordinator
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    // MARK:  Public Methods

    func loadFirstPage() {
        page.reset()
        searchPhotos()
    }
    
    // MARK:  Coordinator
    
    func presentPhoto(photo: Photo) {
        coordinator.presentPhoto(photo: photo)
    }
    
    func presentUserProfile(owner: String) {
        coordinator.presentUserProfile(owner: owner)
    }
}

// MARK:  Paginable
extension HomeViewModel: Paginable {
    func loadMoreIfNeeded() {
        if !isLoadingNewPage {
            page.nextPage()
            searchPhotos()
            isLoadingNewPage = true
        }
    }
}

// MARK:  Private Methods

extension HomeViewModel {
    private func searchPhotos() {
        
        guard !searchText.isEmpty else { return }
        let request = PhotosBaseRequest(text: searchText,
                                        sort: .relevance,
                                        safeSearch: .safe)

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
                    self.isLoadingNewPage = false
                }
                self.status = .loaded
            }.store(in: &cancellables)
    }
}
