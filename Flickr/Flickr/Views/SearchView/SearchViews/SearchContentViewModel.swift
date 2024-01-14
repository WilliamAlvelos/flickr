//
//  SearchContentViewModel.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import Combine

class SearchContentViewModel<T: Codable>: ObservableObject {
    @Published var status: Status = .empty
    @Published var content: [T] = []
        
    internal var cancellables: Set<AnyCancellable> = []
    internal let repository: FlickrRepositoryProtocol
    private let coordinator: SearchViewWireframe
    
    internal var page: Page = Page(page: 1)
    internal var isLoadingNewPage = false
    internal var currentSearch: String = ""
    
    init(repository: FlickrRepositoryProtocol, coordinator: SearchViewWireframe) {
        self.repository = repository
        self.coordinator = coordinator
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    func search(text: String) {
        currentSearch = text
        page.reset()
        search()
    }
    
    func tryAgain() {
        search()
    }
    
    func loadMoreIfNeeded() {
        if isLoadingNewPage {
            return
        }
        isLoadingNewPage = true
        page.nextPage()
        search()
    }
    
    func search() {

    }
    
    // MARK:  Coordinator
    
    func presentPerson(person: String) {
        coordinator.presentUserProfile(owner: person)
    }
    
    func presentPhoto(photo: Photo) {
        coordinator.presentPhoto(photo: photo)
    }
    
    func presentGroup(group: Group) {
        coordinator.presentGroup(group: group)
    }
}
