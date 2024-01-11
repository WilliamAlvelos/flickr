//
//  FlickrRepository.swift
//  Flickr
//
//  Created by William de Alvelos on 11/01/2024.
//

import Foundation
import Combine

protocol FlickrRepositoryProtocol {
//    func findByUsername(name: String) -> AnyPublisher<User, Error>
//    func fetchGallery() -> AnyPublisher<Galleries, Error>
    func searchPhotos(text: String) -> AnyPublisher<BaseRequest<Photos>, Error>
}


class FlickrRepository: FlickrRepositoryProtocol {
    let apiClient = URLSessionAPIClient()

    func searchPhotos(text: String) -> AnyPublisher<BaseRequest<Photos>, Error> {
        apiClient.request(EndPoints.search(text).builder())
    }
//    
//    func fetchGallery() -> AnyPublisher<Galleries, Error> {
//        
//    }
//    
//    func searchPhotos(text: String) -> AnyPublisher<Photos, Error> {
//        
//    }
}
 
