//
//  Page.swift
//  Flickr
//
//  Created by William de Alvelos on 13/01/2024.
//

import Foundation

struct Page {
    var page: Int
    
    mutating func nextPage() {
        self.page += 1
    }
    
    mutating func reset() {
        self.page = 0
    }
}
