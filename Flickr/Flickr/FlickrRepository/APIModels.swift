//
//  APIModels.swift
//  Flickr
//
//  Created by William de Alvelos on 13/01/2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidResponse
    case invalidStatus
    case invalidData
    case unauthorized
}

struct FlickrError: Codable, Error {
    let message: String
    let code: Int
    let stat: ResponseStat
    
    var localizedDescription: String {
        return message
    }
}
