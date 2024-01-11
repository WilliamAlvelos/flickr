//
//  User.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation


struct User: Codable {
    let id: String
    let nsid: String
    let username: UserName
}

struct UserName: Codable {
    let _content: String
}
