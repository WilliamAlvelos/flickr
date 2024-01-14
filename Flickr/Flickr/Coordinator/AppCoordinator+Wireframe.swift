//
//  AppCoordinator+Wireframe.swift
//  Flickr
//
//  Created by William de Alvelos on 12/01/2024.
//

import SwiftUI

// MARK:  HomeViewWireframe

protocol HomeViewWireframe {
    func presentPhoto(photo: Photo)
    func presentUserProfile(owner: String)
}

extension AppCoordinator: HomeViewWireframe {
    func presentPhoto(photo: Photo) {
        present(sheet: .photoDetail(photo: photo))
    }
    
    func presentUserProfile(owner: String) {
        push(screen: Screen.userDetails(owner: owner))
    }
}

// MARK:  SearchViewWireframe

protocol SearchViewWireframe {

    
}
