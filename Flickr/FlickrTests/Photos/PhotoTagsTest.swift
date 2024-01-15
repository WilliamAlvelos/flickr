//
//  PhotoTagsTest.swift
//  FlickrTests
//
//  Created by William de Alvelos on 13/01/2024.
//

import XCTest
@testable import Flickr

class PhotoTagsTest: XCTestCase {
    
    func testMaximumOfTagsShouldBeFour() throws {
        let sut = PhotoFactory.new(tags: "tag1 tag2 tag3 tag4 tag5")
        let expectedTags = [Tag(name: "tag1"), Tag(name: "tag2"), Tag(name: "tag3"), Tag(name: "tag4")]

        XCTAssertEqual(sut.resumedPhotoTags.count, expectedTags.count)
    }
    
    func testTagsNameMaximumOfFourShouldMatch() throws {
        let sut = PhotoFactory.new(tags: "tag1 tag2 tag3 tag4 tag5")
        let expectedTags = [Tag(name: "tag1"), Tag(name: "tag2"), Tag(name: "tag3"), Tag(name: "tag4")]
        
        XCTAssertEqual(sut.resumedPhotoTags[0].name, expectedTags[0].name)
        XCTAssertEqual(sut.resumedPhotoTags[1].name, expectedTags[1].name)
        XCTAssertEqual(sut.resumedPhotoTags[2].name, expectedTags[2].name)
        XCTAssertEqual(sut.resumedPhotoTags[3].name, expectedTags[3].name)
    }
    
    func testCaseWithNoTagsShouldBeEmpty() throws {
        let sut = PhotoFactory.new(tags: "")
        XCTAssertTrue(sut.resumedPhotoTags.isEmpty)
    }
    
    func testCaseWithEmptyTagsShouldBeEmpty() throws {
        let sut = PhotoFactory.new(tags: "       ")
        XCTAssertTrue(sut.resumedPhotoTags.isEmpty)
    }
    
    func testTagsFewerThanFourShouldBeSameNumber() throws {
        let sut = PhotoFactory.new(tags: "tag1 tag2 tag3")

        XCTAssertEqual(sut.resumedPhotoTags.count, 3)
    }
    
    func testTagsFourShouldBeSameNumber() throws {
        let sut = PhotoFactory.new(tags: "tag1 tag2 tag3 tag4")

        XCTAssertEqual(sut.resumedPhotoTags.count, 4)
    }
}
