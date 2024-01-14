//
//  Photo.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation

enum RequestStat: String, Codable {
    case ok
}

struct Photos: Codable {
    let total: Int
    let page: Int
    let pages: Int
    let perpage: Int
    let photo: [Photo]
}

struct PhotosBaseResponse<T: Codable>: Codable {
    let photos: T
    let stat: RequestStat
}

struct Photo: Codable, Photable, BuddyIconable {
    var iconserver: String {
        return server
    }
    
    let identifier = UUID()
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    let tags: String
    let ownername: String
    let datetaken: String
    
    var resumedPhotoTags: [Tag] {
        let filterTags = tags.components(separatedBy: " ")
            .filter({ !$0.isEmpty })
            .prefix(4)
        
        return Array(filterTags.map({ Tag(name: $0) }))
    }
    
    var dateTakesFormated: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: datetaken) {
            dateFormatter.dateFormat = "MMMM d, yyyy"
            
            let formattedDateString = dateFormatter.string(from: date)
            return formattedDateString
        }
        
        return datetaken
    }
}
