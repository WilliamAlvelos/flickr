//
//  Status.swift
//  Flickr
//
//  Created by William de Alvelos on 12/01/2024.
//

import Foundation

enum Status {
    case loading
    case error(error: Error)
    case empty
    case loaded
}
