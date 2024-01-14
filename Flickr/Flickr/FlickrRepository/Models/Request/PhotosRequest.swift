//
//  PhotosRequest.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import Foundation

enum PhotosRequestSort: String {
    case datePostedAsc = "date-posted-asc"
    case datePostedDesc = "date-posted-desc"
    case dateTakenAsc = "date-taken-asc"
    case dateTakenDesc = "date-taken-desc"
    case interestingnessDesc = "interestingness-desc"
    case interestingnessAsc = "interestingness-asc"
    case relevance = "relevance"
}

struct PhotosBaseRequest {
    var text: String? = nil
    var tags: String? = nil
    var userId: String? = nil
    var sort: PhotosRequestSort? = nil
    let safeSearch: SafeSearch
    
    var requestParameters: [String: String] {
        var parameters: [String: String] = [
            "safe_search": "\(safeSearch.rawValue)"
        ]

        if let text = text {
            parameters["text"] = text
        }

        if let tags = tags {
            parameters["tags"] = tags
        }

        if let userId = userId {
            parameters["user_id"] = userId
        }

        if let sort = sort {
            parameters["sort"] = sort.rawValue
        }

        return parameters
    }
}
