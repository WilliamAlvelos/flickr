//
//  Group.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import Foundation

struct GroupBaseResponse<T: Codable>: Codable {
    let groups: T
    let stat: RequestStat
}

struct Groups: Codable {
    let total: Int
    let page: Int
    let pages: Int
    let perpage: Int
    let group: [Group]
}

struct Group: Codable, Identifiable {
    var id: String {
        return nsid
    }
    
    let nsid: String
    let name: String
    let eighteenplus: Int
    let iconserver: String
    let iconfarm: Int
    let members: String
    let poolCount: String
    let topicCount: String
    let privacy: String
}
