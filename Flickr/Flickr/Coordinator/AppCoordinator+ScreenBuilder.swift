//
//  AppCoordinator+ScreenBuilder.swift
//  Flickr
//
//  Created by William de Alvelos on 12/01/2024.
//

import SwiftUI

enum Screen: Identifiable, Hashable {
    case homeView
    case searchView
    case photoDetail(photo: Photo)
    case userDetails(owner: String)
    case groupDetails(group: Group)
    
    var id: String {
        switch self {
        case .homeView:
            return "homeView"
        case .searchView:
            return "searchView"
        case .photoDetail(let photo):
            return photo.id
        case .userDetails(let owner):
            return owner
        case .groupDetails(let group):
            return group.id
        }
    }
}

// MARK:  Screen Builder

extension AppCoordinator {
    @ViewBuilder
    func build(screen: Screen, dependencies: DependenciesProtocol) -> some View {
        switch screen {
        case .homeView:
            HomeView(viewModel: HomeViewModel(repository: dependencies.repository, 
                                              coordinator: self))
        case .searchView:
            SearchView(viewModel: SearchViewModel(repository: dependencies.repository, 
                                                  coordinator: self))
        case .photoDetail(let photo):
            PhotoDetailView(photo: photo)
        case .userDetails(let owner):
            UserDetailView(viewModel: UserDetailViewModel(repository: dependencies.repository, 
                                                          userId: owner))
        case .groupDetails(let group):
            GroupDetail(group: group)
        }
    }
}
