//
//  FlickrApp.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import SwiftUI

@main
struct FlickrApp: App {
    @StateObject private var coordinator = AppCoordinator()
    private let dependencies: Dependencies = Dependencies()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationStack(path: $coordinator.path) {
                    coordinator.build(screen: .homeView)
                        .navigationDestination(for: Screen.self) { screen in
                            coordinator.build(screen: screen)
                        }
                        .sheet(item: $coordinator.sheet) { sheet in
                            coordinator.build(screen: sheet)
                        }
                }.tabItem {
                    Label("Home",
                          systemImage: "photo.artframe.circle")
                }
                
                NavigationStack(path: $coordinator.path) {
                    coordinator.build(screen: .searchView)
                        .navigationDestination(for: Photo.self) { photo in
                            coordinator.build(screen: .photoDetail(photo: photo))
                        }
                    
                }.tabItem {
                    Label("Search",
                          systemImage: "magnifyingglass.circle")
                }
            }
        }.environmentObject(coordinator)
    }
}
