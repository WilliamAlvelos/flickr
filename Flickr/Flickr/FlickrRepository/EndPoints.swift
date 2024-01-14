//
//  EndPoints.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation

enum EndPoints {
    static let baseURL = URL(string: "https://www.flickr.com/")! // TODO:  MOVE THIS TO A CONFIG FILE

    case searchPhotos(request: PhotosBaseRequest, page: Page)
    case groupsSearch(text: String, page: Page)
    case personInfo(userId: String)
    case userSearch(userName: String)
    
    func builder() -> Requestable {
        switch self {
        case .searchPhotos(let request, let page):
            
            let additionalParameters: [String: String] = [
                "method": "flickr.photos.search",
                "page": "\(page.page)",
                "extras": "tags,owner_name,date_taken"
            ]
            
            let mergedParameters = request.requestParameters.merging(additionalParameters) { (value, _) in value }

            return Request(baseURL: EndPoints.baseURL,
                           path: "services/rest",
                           method: .get,
                           parameters: mergedParameters)
            
        case .groupsSearch(let text, let page):
            return Request(baseURL: EndPoints.baseURL,
                           path: "services/rest",
                           method: .get,
                           parameters: ["method": "flickr.groups.search",
                                        "text": text,
                                        "page": "\(page.page)"])
            
        case .userSearch(let userName):
            return Request(baseURL: EndPoints.baseURL,
                           path: "services/rest",
                           method: .get,
                           parameters: ["method": "flickr.people.findByUsername",
                                        "username": userName])
        case .personInfo(let userId):
            return Request(baseURL: EndPoints.baseURL,
                           path: "services/rest",
                           method: .get,
                           parameters: ["method": "flickr.people.getInfo",
                                        "user_id": userId])
        }
    }
}
