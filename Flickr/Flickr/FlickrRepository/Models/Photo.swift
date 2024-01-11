//
//  Photo.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation

struct Photos: Codable {
    let total: Int
    let page: Int
    let pages: Int
    let perpage: Int
    let photo: [Photo]
}

struct BaseRequest<T: Codable>: Codable {
    let photos: T
    let stat: RequestStat
}

enum RequestStat: String, Codable {
    case ok
}

struct Photo: Codable, Identifiable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    
    var photoURL: URL? {
        let string = "https://live.staticflickr.com/\(server)/\(id)_\(secret)_w.jpg"
        guard let url = URL(string: string) else { return nil }
        return url
    }
}
