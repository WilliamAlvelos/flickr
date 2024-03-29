//
//  User.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation

struct UserBaseResponse<T: Codable>: Codable {
    let user: T
    let stat: ResponseStat
}

struct User: Codable {
    let id: String
    let nsid: String
    let username: DataContent<String>
}

struct DataContent<T: Codable>: Codable {
    let _content: T
}



