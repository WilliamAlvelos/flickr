//
//  UrlMaker.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import Foundation

protocol Photable: Identifiable, Hashable {
    var server: String { get }
    var id: String { get }
    var secret: String { get }
}

protocol BuddyIconable {
    var iconserver: String { get }
    var owner: String { get }
}

protocol CoverPhotable {
    var iconfarm: Int { get }
    var iconserver: String { get }
    var id: String { get }
}

// TODO: Create a file for the base url
extension BuddyIconable {
    var iconURL: URL? { URL(string: "https://live.staticflickr.com/\(iconserver)/buddyicons/\(owner)_r.jpg") }
}

extension Photable {
    var photoURL: URL? { URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret)_z.jpg") }
}

extension CoverPhotable {
    var coverURL: URL? { URL(string: "https://farm\(iconfarm).staticflickr.com/\(iconserver)/coverphoto/\(id)_h.jpg") }
}
