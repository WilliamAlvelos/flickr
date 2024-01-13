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

struct PhotosBaseRequest<T: Codable>: Codable {
    let photos: T
    let stat: RequestStat
}

enum RequestStat: String, Codable {
    case ok
}

struct Photo: Codable, Identifiable, Hashable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    
    // MARK:  Extras
//    let latitude: String 🤣🤣
//    let longitude: String
    let tags: String
    let ownername: String
    let datetaken: String
    
    // TODO: MOVE THE live.staticflickr TO A BASE STRING
    var photoURL: URL? {
        let string = "https://live.staticflickr.com/\(server)/\(id)_\(secret)_z.jpg"
        guard let url = URL(string: string) else { return nil }
        return url
    }
    
    // TODO:  MOVE THIS TO SOMEWHERE ELSE WE CAN REUSE
    
    var ownerPhotoURL: URL? {
        let string = "https://live.staticflickr.com/\(server)/buddyicons/\(owner)_s.jpg"
        guard let url = URL(string: string) else { return nil }
        return url
    }
    
    var photoTags: [Tag] {
        let filterTags = tags.components(separatedBy: " ")
            .filter({ !$0.isEmpty })
            .prefix(4)
        
        return Array(filterTags.map({ Tag(name: $0) }))
    }
}



struct Tag: Identifiable {
    let id = UUID()
    let name: String
}
