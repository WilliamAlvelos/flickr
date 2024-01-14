//
//  PhotoFactory.swift
//  FlickrTests
//
//  Created by William de Alvelos on 13/01/2024.
//

import Foundation
@testable import Flickr

class PhotoFactory {
    static func new(id: String = "mock data testing",
                    owner: String = "mock data testing",
                    secret: String = "mock data testing",
                    server: String = "mock data testing",
                    farm: Int = 0,
                    title: String = "mock data testing",
                    ispublic: Int = 0,
                    isfriend: Int = 0,
                    isfamily: Int = 0,
                    tags: String = "mock data testing",
                    ownername: String = "mock data testing",
                    datetaken: String = "mock data testing") -> Photo {
        let photo = Photo(id: id,
                          owner: owner,
                          secret: secret,
                          server: server,
                          farm: farm,
                          title: title,
                          ispublic: ispublic,
                          isfriend: isfriend,
                          isfamily: isfamily,
                          tags: tags,
                          ownername: ownername,
                          datetaken: datetaken)
        return photo
    }
}
