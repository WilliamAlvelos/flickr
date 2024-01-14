//
//  Dependencies.swift
//  Flickr
//
//  Created by William de Alvelos on 12/01/2024.
//

import Foundation

protocol DependenciesProtocol {
    var repository: FlickrRepositoryProtocol { get }
}

class Dependencies: DependenciesProtocol {
    lazy var repository: FlickrRepositoryProtocol = FlickrRepository()
}
