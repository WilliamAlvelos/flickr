//
//  People.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import Foundation

struct PeopleBaseResponse<T: Codable>: Codable {
    let people: T
    let stat: RequestStat
}

struct PeoplePage: Codable {
    let total: Int
    let perPage: Int
    let page: Int
    let pages: Int
    let person: [SearchPerson]
}

struct SearchPerson: Codable, Identifiable, BuddyIconable {
    var owner: String {
        return nsid
    }
    
    var id: String {
        return nsid
    }
    
    let dbid: String
    let nsid: String
    let username: String
    let realname: String
    let iconserver: String
    let iconfarm: Int
    let pathAlias: String?
    let ignored: Int
    let contact: Int
    let friend: Int
    let family: Int
    let isPro: Int
    let expire: String?
    let proBadge: String?
}


