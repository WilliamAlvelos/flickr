//
//  EndPoints.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation

enum EndPoints {
    static let baseURL = URL(string: "https://www.flickr.com/")! // TODO:  MOVE THIS TO A CONFIG FILE

    case search(text: String, safeSearch: SafeSearch, page: Page)
    case photos(userId: String, safeSearch: SafeSearch, page: Page)
    case personInfo(userId: String)
    case userSearch(userName: String)
    
    func builder() -> Requestable {
        switch self {
        case .search(let text, let safeSearch, let page):
            return Request(baseURL: EndPoints.baseURL,
                           path: "services/rest",
                           method: .get,
                           parameters: ["method": "flickr.photos.search",
                                        "text": text,
                                        "safe_search": "\(safeSearch.rawValue)",
                                        "page": "\(page.page)",
                                        "extras": "tags,owner_name,date_taken"])
        case .userSearch(let userName):
            return Request(baseURL: EndPoints.baseURL,
                           path: "services/rest",
                           method: .get,
                           parameters: ["method": "flickr.people.findByUsername",
                                        "username": userName])
        case .photos(let userId, let safeSearch, let page):
            return Request(baseURL: EndPoints.baseURL,
                           path: "services/rest",
                           method: .get,
                           parameters: ["method": "flickr.people.getPhotos",
                                        "safe_search": "\(safeSearch.rawValue)",
                                        "page": "\(page.page)",
                                        "user_id": userId,
                                        "extras": "tags,owner_name,date_taken"])
            
        case .personInfo(let userId):
            return Request(baseURL: EndPoints.baseURL,
                           path: "services/rest",
                           method: .get,
                           parameters: ["method": "flickr.people.getInfo",
                                        "user_id": userId])
        }
    }
}
