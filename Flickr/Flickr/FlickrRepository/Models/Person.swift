//
//  Person.swift
//  Flickr
//
//  Created by William de Alvelos on 13/01/2024.
//

import Foundation

struct PersonBaseRequest<T: Codable>: Codable {
    let person: T
    let stat: RequestStat
}

// TODO:  Transform Int into Bool
struct Person: Codable {
    let id: String
    let nsid: String
    let ispro: Int
    let isDeleted: Int
    let iconserver: String
    let iconfarm: Int
    let pathAlias: String?
    let hasStats: Int
    let proBadge: String? // TODO:  CREATE AN ENUM ?
    let expire: String?
    let username: DataContent<String>
    let realname: DataContent<String>?
    let location: DataContent<String>?
    let description: DataContent<String>
    let photosurl: DataContent<String>
    let profileurl: DataContent<String>
    let mobileurl: DataContent<String>
    let photos: PersonPhotos
    let hasAdfree: Int
    let hasFreeStandardShipping: Int
    let hasFreeEducationalResources: Int
    
    var ownerPhotoURL: URL? {
        let string = "https://live.staticflickr.com/\(iconserver)/buddyicons/\(id)_s.jpg"
        guard let url = URL(string: string) else { return nil }
        return url
    }
    
    var coverPhotoURL: URL? {
        let string = "https://farm\(iconfarm).staticflickr.com/\(iconserver)/coverphoto/\(id)_h.jpg"
        guard let url = URL(string: string) else { return nil }
        return url
    }
}

struct PersonPhotos: Codable {
    let firstdatetaken: DataContent<String>
    let firstdate: DataContent<String>
    let count: DataContent<Int>
}
