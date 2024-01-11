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
    @Published var photos = [Photo]()
    private var cancellable: Set<AnyCancellable> = []
    private var repository: FlickrRepositoryProtocol = FlickrRepository() // TODO:  INSERT THIS USING DEPENDENCY INJECTION
    
    func searchPhotos(text: String) {
        repository.searchPhotos(text: text, safeSearch: .safe)
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
