//
//  FlickrApp.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import SwiftUI

@main
struct FlickrApp: App {
    
    private let dependencies: Dependencies = Dependencies()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    HomeView(viewModel: HomeViewModel())
                }.tabItem {
                    Label("Home",
                          systemImage: "photo.artframe.circle")
                }
                
                NavigationView {
                    SearchView(viewModel: SearchViewModel())
                }.tabItem {
                    Label("Search",
                          systemImage: "magnifyingglass.circle")
                }
            }.accentColor(Color.primaryBlue)
        }
    }
}

class Dependencies {
    
}
