//
//  Status.swift
//  Flickr
//
//  Created by William de Alvelos on 12/01/2024.
//

import Foundation

enum Status: Equatable {
    case loading
    case error(error: Error)
    case empty
    case loaded
    
    
    static func == (lhs: Status, rhs: Status) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.error(_), .error(_)):
            return true
        case (.empty, .empty):
            return true
        case (.loaded, .loaded):
            return true
        default:
            return false
        }
    }
}
