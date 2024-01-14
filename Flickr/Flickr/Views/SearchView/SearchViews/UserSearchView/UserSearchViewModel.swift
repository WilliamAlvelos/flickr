//
//  UserSearchViewModel.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import Foundation
import Combine

final class UserSearchViewModel: ObservableObject {
    @Published var status: Status = .empty
    @Published var people: [SearchPerson] = []
    
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
    
    func search(userName: String) {
        currentSearch = userName
        page.reset()
        searchUsers()
    }
    
    func tryAgain() {
        searchUsers()
    }
    
    func loadMoreIfNeeded() {
        if isLoadingNewPage {
            return
        }
        isLoadingNewPage = true
        page.nextPage()
        searchUsers()
    }
    
    // MARK:  Coordinator
    
    func presentPerson(person: String) {
        coordinator.presentUserProfile(owner: person)
    }
}

// MARK:  Private Methods

extension UserSearchViewModel {
    
    private func searchUsers() {
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
                guard !response.people.person.isEmpty else {
                    self.status = .empty
                    return
                }
                
                if response.people.page == "1" { // WHY FLICKR 🤣
                    self.people = response.people.person
                } else {
                    self.people += response.people.person
                    self.isLoadingNewPage = false
                }
                self.status = .loaded
            }.store(in: &cancellable)
    }
}
