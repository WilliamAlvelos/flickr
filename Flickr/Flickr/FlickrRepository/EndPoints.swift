//
//  EndPoints.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation

enum EndPoints {
    static let baseURL = URL(string: "https://www.flickr.com/")!

    case search(text: String, safeSearch: SafeSearch)

    func builder() -> Requestable {
        switch self {
        case .search(let text, let safeSearch):
            return Request(baseURL: EndPoints.baseURL,
                           path: "services/rest",
                           method: .get,
                           parameters: ["method": "flickr.photos.search",
                                        "text": text,
                                        "safe_search": "\(safeSearch.rawValue)"])
        }
    }
}
