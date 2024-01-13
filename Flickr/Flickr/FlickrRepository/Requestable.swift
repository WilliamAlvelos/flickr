//
//  Requestable.swift
//  Flickr
//
//  Created by William de Alvelos on 12/01/2024.
//

import Foundation

protocol Requestable {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: String] { get }
    var body: Encodable? { get }
}

struct Request: Requestable {
    var baseURL: URL
    var path: String
    var method: HTTPMethod
    var headers: [String: String]?
    var parameters: [String: String]
    var body: Encodable?
}
