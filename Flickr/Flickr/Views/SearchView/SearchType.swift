//
//  SearchType.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import Foundation

enum SearchType: Int {
    case photos = 0
    case tags = 1
    case groups = 2
    
    var emptyViewType: FLEmptyViewType {
        switch self {
        case .photos:
            return FLEmptyViewType.photos
        case .tags:
            return FLEmptyViewType.tags
        case .groups:
            return FLEmptyViewType.groups
        }
    }
    
    var searchPlaceholder: String {
        switch self {
        case .photos:
            return "Search.Placeholder.Photos".local
        case .tags:
            return "Search.Placeholder.Tags".local
        case .groups:
            return "Search.Placeholder.Groups".local
        }
    }
}
