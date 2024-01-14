//
//  EndpointsTests.swift
//  FlickrTests
//
//  Created by William de Alvelos on 13/01/2024.
//

import XCTest
@testable import Flickr

final class EndpointsTests: XCTestCase {

    
    func testEndpointSeachPhotosOnlySafeSearch() throws {
        let request = PhotosBaseRequest(safeSearch: .safe)
        let sut: Requestable = EndPoints.searchPhotos(request: request,
                                                      page: Page(page: 0)).builder()
        
        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.photos.search")
        XCTAssertEqual(sut.parameters["safe_search"], "\(SafeSearch.safe.rawValue)")
        XCTAssertEqual(sut.parameters["page"], "0")
        XCTAssertEqual(sut.parameters["extras"], "tags,owner_name,date_taken")
        
        XCTAssertNil(sut.parameters["text"])
        XCTAssertNil(sut.parameters["tags"])
        XCTAssertNil(sut.parameters["user_id"])
        XCTAssertNil(sut.parameters["sort"])
    }
    
    func testEndpointSeachPhotosWithText() throws {
        let request = PhotosBaseRequest(text: "text mocked", safeSearch: .safe)
        let sut: Requestable = EndPoints.searchPhotos(request: request,
                                                      page: Page(page: 0)).builder()
        
        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.photos.search")
        XCTAssertEqual(sut.parameters["safe_search"], "\(SafeSearch.safe.rawValue)")
        XCTAssertEqual(sut.parameters["text"], "text mocked")
        XCTAssertEqual(sut.parameters["page"], "0")
        XCTAssertEqual(sut.parameters["extras"], "tags,owner_name,date_taken")
        
        XCTAssertNil(sut.parameters["tags"])
        XCTAssertNil(sut.parameters["user_id"])
        XCTAssertNil(sut.parameters["sort"])
    }
    
    func testEndpointSeachPhotosWithTags() throws {
        let request = PhotosBaseRequest(tags: "tags mocked", safeSearch: .safe)
        let sut: Requestable = EndPoints.searchPhotos(request: request,
                                                      page: Page(page: 0)).builder()
        
        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.photos.search")
        XCTAssertEqual(sut.parameters["safe_search"], "\(SafeSearch.safe.rawValue)")
        XCTAssertEqual(sut.parameters["tags"], "tags mocked")
        XCTAssertEqual(sut.parameters["page"], "0")
        XCTAssertEqual(sut.parameters["extras"], "tags,owner_name,date_taken")
        
        XCTAssertNil(sut.parameters["text"])
        XCTAssertNil(sut.parameters["user_id"])
        XCTAssertNil(sut.parameters["sort"])
    }
    
    func testEndpointSeachPhotosWithUserId() throws {
        let request = PhotosBaseRequest(userId: "user_id mocked", safeSearch: .safe)
        let sut: Requestable = EndPoints.searchPhotos(request: request,
                                                      page: Page(page: 0)).builder()
        
        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.photos.search")
        XCTAssertEqual(sut.parameters["safe_search"], "\(SafeSearch.safe.rawValue)")
        XCTAssertEqual(sut.parameters["user_id"], "user_id mocked")
        XCTAssertEqual(sut.parameters["page"], "0")
        XCTAssertEqual(sut.parameters["extras"], "tags,owner_name,date_taken")
        
        XCTAssertNil(sut.parameters["text"])
        XCTAssertNil(sut.parameters["tags"])
        XCTAssertNil(sut.parameters["sort"])
    }
    
    
    func testEndpointSeachPhotosWithAllParametersSetAndPageOne() throws {
        let request = PhotosBaseRequest(text: "text mocked",
                                        tags: "tags mocked",
                                        userId: "user_id mocked",
                                        sort: .relevance,
                                        safeSearch: .safe)
        let sut: Requestable = EndPoints.searchPhotos(request: request,
                                                      page: Page(page: 1)).builder()
        
        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.photos.search")
        XCTAssertEqual(sut.parameters["safe_search"], "\(SafeSearch.safe.rawValue)")
        
        XCTAssertEqual(sut.parameters["text"], "text mocked")
        XCTAssertEqual(sut.parameters["tags"], "tags mocked")
        XCTAssertEqual(sut.parameters["user_id"], "user_id mocked")
        XCTAssertEqual(sut.parameters["sort"], "relevance")
        
        XCTAssertEqual(sut.parameters["page"], "1")
        XCTAssertEqual(sut.parameters["extras"], "tags,owner_name,date_taken")
    }

    func testUserSearchEndpoint() throws {
        let sut: Requestable = EndPoints.userSearch(userName: "userName").builder()
        
        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.people.findByUsername")
        XCTAssertEqual(sut.parameters["username"], "userName")
    }
    
    func testPersonInfoEndpoint() throws {
        let sut: Requestable = EndPoints.personInfo(userId: "userId").builder()
        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.people.getInfo")
        XCTAssertEqual(sut.parameters["user_id"], "userId")
    }
}
