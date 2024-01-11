//
//  HomeViewModel.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation
import Combine

// TODO:  Move this to a better place
enum Status {
    case loading
    case error(error: Error)
    case empty
    case loaded
}

enum SafeSearch: Int {
    case safe = 1
    case moderate = 2
    case restricted = 3
}

final class HomeViewModel: ObservableObject {
    
    @Published var status: Status = .loading
    @Published var photos = [Photo]()
    private var cancellable: Set<AnyCancellable> = []
    private var repository: FlickrRepositoryProtocol = FlickrRepository()
    private var searchText = "yorkshire"
    
    func searchPhotos() {
        repository.searchPhotos(text: searchText, safeSearch: .safe)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { photos in
                self.photos = photos.photos.photo
            }.store(in: &cancellable)
    }
}