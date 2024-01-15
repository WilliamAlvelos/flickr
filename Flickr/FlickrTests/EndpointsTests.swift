//
//  EndpointsTests.swift
//  FlickrTests
//
//  Created by William de Alvelos on 13/01/2024.
//

import XCTest
@testable import Flickr

final class EndpointsTests: XCTestCase {
    func testEndpointSearchGroups() throws {
        let sut: Requestable = EndPoints.searchGroups(text: "search groups",
                                                      page: Page(page: 0)).builder()
        
        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.groups.search")
        XCTAssertEqual(sut.parameters["page"], "0")
        XCTAssertEqual(sut.parameters["text"], "search groups")
    }
    
    func testEndpointSearchUserByUsername() throws {
        let sut: Requestable = EndPoints.searchUser(userName: "search username",
                                                    page: Page(page: 0)).builder()
        
        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.people.search")
        XCTAssertEqual(sut.parameters["page"], "0")
        XCTAssertEqual(sut.parameters["username"], "search username")
    }
    
    func testPersonInfoEndpoint() throws {
        let sut: Requestable = EndPoints.personInfo(userId: "userId").builder()
        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.people.getInfo")
        XCTAssertEqual(sut.parameters["user_id"], "userId")
    }
    
    func testEndpointSearchPhotosOnlySafeSearch() throws {
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
    
    func testEndpointSearchPhotosWithText() throws {
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
    
    func testEndpointSearchPhotosWithTags() throws {
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
    
    func testEndpointSearchPhotosWithTagModeAll() throws {
        let request = PhotosBaseRequest(tags: "tags mocked",
                                        tagMode: .all,
                                        safeSearch: .safe)
        let sut: Requestable = EndPoints.searchPhotos(request: request,
                                                      page: Page(page: 0)).builder()
        
        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.photos.search")
        XCTAssertEqual(sut.parameters["safe_search"], "\(SafeSearch.safe.rawValue)")
        XCTAssertEqual(sut.parameters["tags"], "tags mocked")
        XCTAssertEqual(sut.parameters["tag_mode"], "all")
        XCTAssertEqual(sut.parameters["page"], "0")
        XCTAssertEqual(sut.parameters["extras"], "tags,owner_name,date_taken")
        
        XCTAssertNil(sut.parameters["text"])
        XCTAssertNil(sut.parameters["user_id"])
        XCTAssertNil(sut.parameters["sort"])
    }
    
    func testEndpointSearchPhotosWithTagModeAny() throws {
        let request = PhotosBaseRequest(tags: "tags mocked",
                                        tagMode: .any,
                                        safeSearch: .safe)
        let sut: Requestable = EndPoints.searchPhotos(request: request,
                                                      page: Page(page: 0)).builder()
        
        XCTAssertEqual(sut.path, "services/rest")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.parameters["method"], "flickr.photos.search")
        XCTAssertEqual(sut.parameters["safe_search"], "\(SafeSearch.safe.rawValue)")
        XCTAssertEqual(sut.parameters["tags"], "tags mocked")
        XCTAssertEqual(sut.parameters["tag_mode"], "any")
        XCTAssertEqual(sut.parameters["page"], "0")
        XCTAssertEqual(sut.parameters["extras"], "tags,owner_name,date_taken")
        
        XCTAssertNil(sut.parameters["text"])
        XCTAssertNil(sut.parameters["user_id"])
        XCTAssertNil(sut.parameters["sort"])
    }
    
    func testEndpointSearchPhotosWithUserId() throws {
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
    
    
    func testEndpointSearchPhotosWithAllParametersSetAndPageOne() throws {
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
}
