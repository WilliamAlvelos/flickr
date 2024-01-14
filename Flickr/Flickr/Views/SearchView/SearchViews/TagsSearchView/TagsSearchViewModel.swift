//
//  TagsSearchViewModel.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import Foundation
import Combine

final class TagsSearchViewModel: SearchContentViewModel<Photo> {
    override func search() {
        searchPhotos()
    }
    
    func searchPhotos() {
        if page.page == 1 {
            self.status = .loading
        }
        
        let request = PhotosBaseRequest(tags: currentSearch, safeSearch: .safe)
        
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
                    self.content = response.photos.photo
                } else {
                    self.content += response.photos.photo
                    self.isLoadingNewPage = false
                }
                self.status = .loaded
            }.store(in: &cancellables)
    }
}
