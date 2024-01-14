//
//  FlickrApp.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import SwiftUI

@main
struct FlickrApp: App {
    @StateObject private var homeCoordinator = AppCoordinator()
    @StateObject private var searchCoordinator = AppCoordinator()
    
    private let dependencies: DependenciesProtocol = Dependencies()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                
                NavigationStack(path: $homeCoordinator.path) {
                    homeCoordinator.build(screen: .homeView, dependencies: dependencies)
                        .navigationDestination(for: Screen.self) { screen in
                            homeCoordinator.build(screen: screen, dependencies: dependencies)
                        }
                        .sheet(item: $homeCoordinator.sheet) { sheet in
                            homeCoordinator.build(screen: sheet, dependencies: dependencies)
                        }
                }.tabItem {
                    Label("NavigationTitle.Home",
                          systemImage: "photo.artframe.circle")
                }
                
                NavigationStack(path: $searchCoordinator.path) {
                    searchCoordinator.build(screen: .searchView, dependencies: dependencies)
                        .navigationDestination(for: Photo.self) { photo in
                            searchCoordinator.build(screen: .photoDetail(photo: photo), dependencies: dependencies)
                        }
                        .sheet(item: $searchCoordinator.sheet) { sheet in
                            searchCoordinator.build(screen: sheet, dependencies: dependencies)
                        }
                }.tabItem {
                    Label("NavigationTitle.Search",
                          systemImage: "magnifyingglass.circle")
                }
            }
        }
    }
}
