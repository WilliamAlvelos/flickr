//
//  PersonFactory.swift
//  FlickrTests
//
//  Created by William de Alvelos on 15/01/2024.
//

import Foundation
@testable import Flickr

struct PersonFactory {
    
    static func new(id: String = "mockId",
                    nsid: String = "mockNsid",
                    ispro: Int = 1,
                    isDeleted: Int = 0,
                    iconserver: String = "mockIconServer",
                    iconfarm: Int = 0,
                    pathAlias: String? = nil,
                    hasStats: Int = 1,
                    proBadge: String? = "mockProBadge",
                    expire: String? = nil,
                    username: DataContent<String> = DataContent(_content: "mockUsername"),
                    realname: DataContent<String>? = DataContent(_content: "mockRealname"),
                    location: DataContent<String>? = DataContent(_content: "mockLocation"),
                    description: DataContent<String> = DataContent(_content: "mockDescription"),
                    photosurl: DataContent<String> = DataContent(_content: "mockPhotosUrl"),
                    profileurl: DataContent<String> = DataContent(_content: "mockProfileUrl"),
                    mobileurl: DataContent<String> = DataContent(_content: "mockMobileUrl"),
                    photos: PersonPhotos = PersonPhotos(firstdatetaken: DataContent(_content: "firstdatetaken"),
                                                        firstdate: DataContent(_content: "firstdate"),
                                                        count: DataContent(_content: 10)),
                    hasAdfree: Int = 1,
                    hasFreeStandardShipping: Int = 1,
                    hasFreeEducationalResources: Int = 1) -> Person {
        
        return Person(id: id,
                      nsid: nsid,
                      ispro: ispro,
                      isDeleted: isDeleted,
                      iconserver: iconserver,
                      iconfarm: iconfarm,
                      pathAlias: pathAlias,
                      hasStats: hasStats,
                      proBadge: proBadge,
                      expire: expire,
                      username: username,
                      realname: realname,
                      location: location,
                      description: description,
                      photosurl: photosurl,
                      profileurl: profileurl,
                      mobileurl: mobileurl,
                      photos: photos,
                      hasAdfree: hasAdfree,
                      hasFreeStandardShipping: hasFreeStandardShipping,
                      hasFreeEducationalResources: hasFreeEducationalResources)
    }
}
