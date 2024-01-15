//
//  UserSearchViewModel.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import Foundation
import Combine

final class UserSearchViewModel: SearchContentViewModel<SearchPerson> {

    override func search() {
        searchPeople()
    }
    
    func searchPeople() {
        if page.page == 1 {
            self.status = .loading
        }
        
        repository.searchUserBy(userName: currentSearch, page: page)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.status = .error(error: error)
                }
            } receiveValue: { response in
                if response.people.page == "1" { // WHY FLICKR 🤣
                    guard !response.people.person.isEmpty else {
                        self.status = .empty
                        return
                    }
                    
                    self.content = response.people.person
                } else {
                    self.content += response.people.person
                    self.isLoadingNewPage = false
                }
                self.status = .loaded
            }.store(in: &cancellables)
    }
}
