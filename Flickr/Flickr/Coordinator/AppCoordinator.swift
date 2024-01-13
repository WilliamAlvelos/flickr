//
//  AppCoordinator.swift
//  Flickr
//
//  Created by William de Alvelos on 12/01/2024.
//

import SwiftUI

final class AppCoordinator: ObservableObject {
    internal let dependencies: Dependencies = Dependencies()

    @Published var path = NavigationPath()
    @Published var sheet: Screen?
    
    func push(screen: any Hashable) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func present(sheet: Screen) {
        self.sheet = sheet
    }
    
    func dismiss() {
        self.sheet = nil
    }
}
