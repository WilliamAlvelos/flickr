//
//  User.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation

struct UserBaseRequest<T: Codable>: Codable {
    let user: T
    let stat: RequestStat
}

struct User: Codable {
    let id: String
    let nsid: String
    let username: DataContent<String>
}

struct DataContent<T: Codable>: Codable {
    let _content: T
}



