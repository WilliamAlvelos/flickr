//
//  SearchType.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import Foundation

enum SearchType: Int {
    case tags = 0
    case user = 1
    case groups = 2
    
    var emptyViewType: FLEmptyViewType {
        switch self {
        case .user:
            return FLEmptyViewType.user
        case .tags:
            return FLEmptyViewType.tags
        case .groups:
            return FLEmptyViewType.groups
        }
    }
    
    var searchPlaceholder: String {
        switch self {
        case .tags:
            return "Search.Placeholder.Tags".local
        case .user:
            return "Search.Placeholder.User".local
        case .groups:
            return "Search.Placeholder.Groups".local
        }
    }
}
