//
//  Gallery.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation

struct Galleries: Codable {
    let total: Int
    let perPage: Int
    let userId: String
    let page: Int
    let pages: Int
    let gallery: [Gallery]
}

struct Gallery: Codable {
    
}

