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
    case searchGroups(text: String, page: Page)
    case searchUser(userName: String, page: Page)
    case personInfo(userId: String)
    
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
            
        case .searchGroups(let text, let page):
            return Request(baseURL: EndPoints.baseURL,
                           path: "services/rest",
                           method: .get,
                           parameters: ["method": "flickr.groups.search",
                                        "text": text,
                                        "page": "\(page.page)"])
            
        case .searchUser(let userName, let page):
            return Request(baseURL: EndPoints.baseURL,
                           path: "services/rest",
                           method: .get,
                           parameters: ["method": "flickr.people.search",
                                        "username": userName,
                                        "page": "\(page.page)"])
        case .personInfo(let userId):
            return Request(baseURL: EndPoints.baseURL,
                           path: "services/rest",
                           method: .get,
                           parameters: ["method": "flickr.people.getInfo",
                                        "user_id": userId])
        }
    }
}
