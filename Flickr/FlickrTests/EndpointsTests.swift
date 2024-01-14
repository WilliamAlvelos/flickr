//
//  EndpointsTests.swift
//  FlickrTests
//
//  Created by William de Alvelos on 13/01/2024.
//

import XCTest
@testable import Flickr

final class EndpointsTests: XCTestCase {
    func testPersonInfoEndpoint() throws {
        let sut: Requestable = EndPoints.personInfo(userId: "userId").builder()
        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.people.getInfo")
        XCTAssertEqual(sut.parameters["user_id"], "userId")
    }
    
    func testPhotosEndpoint() throws {
        let sut: Requestable = EndPoints.photos(userId: "userId",
                                                safeSearch: .safe,
                                                page: Page(page: 0)).builder()
        
        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.people.getPhotos")
        XCTAssertEqual(sut.parameters["safe_search"], "\(SafeSearch.safe.rawValue)")
        XCTAssertEqual(sut.parameters["page"], "0")
        XCTAssertEqual(sut.parameters["user_id"], "userId")
        XCTAssertEqual(sut.parameters["extras"], "tags,owner_name,date_taken")
    }
    
    func testSearchInfoEndpoint() throws {
        let sut: Requestable = EndPoints.search(text: "text",
                                                safeSearch: SafeSearch.restricted,
                                                page: Page(page: 1)).builder()

        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.photos.search")
        XCTAssertEqual(sut.parameters["safe_search"], "\(SafeSearch.restricted.rawValue)")
        XCTAssertEqual(sut.parameters["page"], "1")
        XCTAssertEqual(sut.parameters["text"], "text")
        XCTAssertEqual(sut.parameters["extras"], "tags,owner_name,date_taken")
    }
    
    func testUserSearchEndpoint() throws {
        let sut: Requestable = EndPoints.userSearch(userName: "userName").builder()
        
        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.people.findByUsername")
        XCTAssertEqual(sut.parameters["username"], "userName")
    }
}
