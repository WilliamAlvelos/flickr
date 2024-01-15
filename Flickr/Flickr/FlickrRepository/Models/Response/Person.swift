//
//  Person.swift
//  Flickr
//
//  Created by William de Alvelos on 13/01/2024.
//

import Foundation

struct PersonBaseResponse<T: Codable>: Codable {
    let person: T
    let stat: ResponseStat
}

struct Person: Codable, BuddyIconable, CoverPhotable {    
    var server: String {
        return iconserver
    }
    
    var owner: String {
        return id
    }
    
    let id: String
    let nsid: String
    let ispro: Int
    let isDeleted: Int
    let iconserver: String
    let iconfarm: Int
    let pathAlias: String?
    let hasStats: Int
    let proBadge: String?
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
}

struct PersonPhotos: Codable {
    let firstdatetaken: DataContent<String>?
    let firstdate: DataContent<String>?
    let count: DataContent<Int>
}
