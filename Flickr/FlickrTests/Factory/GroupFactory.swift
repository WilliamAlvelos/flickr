//
//  GroupFactory.swift
//  FlickrTests
//
//  Created by William de Alvelos on 14/01/2024.
//

import Foundation
@testable import Flickr

class GroupFactory {
    static func new(id: String = "mock data testing",
                    name: String = "mock data testing",
                    eighteenplus: Int = 0,
                    iconserver: String = "mock data testing",
                    iconfarm: Int = 0,
                    members: String = "mock data testing",
                    poolCount: String = "mock data testing",
                    topicCount: String = "mock data testing",
                    privacy: String = "mock data testing",
                    coverphotoUrl: CoverPhotos = CoverPhotos(h: "image",
                                                             l: "image",
                                                             s: "image",
                                                             t: "image")) -> Group {
        let group = Group(nsid: id,
                          name: name,
                          eighteenplus: eighteenplus,
                          iconserver: iconserver,
                          iconfarm: iconfarm,
                          members: members,
                          poolCount: poolCount,
                          topicCount: topicCount,
                          privacy: privacy,
                          coverphotoUrl: coverphotoUrl)
        return group
    }
}
