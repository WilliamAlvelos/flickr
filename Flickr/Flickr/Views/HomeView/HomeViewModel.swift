//
//  HomeViewModel.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation
import Combine


enum Status {
    case loading
    case error(error: Error)
    case empty
    case loaded
}

final class HomeViewModel: ObservableObject {
    
    @Published var status: Status = .loading
    @Published var photos = [Photo]()
    private var cancellable: Set<AnyCancellable> = []
    private var repository: FlickrRepositoryProtocol = FlickrRepository()
    
    
    func searchPhotos(text: String) {
        repository.searchPhotos(text: text)
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
