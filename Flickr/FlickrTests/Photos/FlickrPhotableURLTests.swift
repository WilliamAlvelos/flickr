//
//  FlickrPhotableURLTests.swift
//  FlickrTests
//
//  Created by William de Alvelos on 14/01/2024.
//

import XCTest
@testable import Flickr

class FlickrPhotableURLTests: XCTestCase {

    struct MockPhoto: Photable {
        var server: String
        var id: String
        var secret: String
    }
    
    // MARK: - Photable Photo Tests

    func testPhotablePhotoURL() {
        let mockPhoto = MockPhoto(server: "server", id: "id", secret: "secret")
        let expectedURL = URL(string: "https://live.staticflickr.com/server/id_secret_z.jpg")
        XCTAssertNotNil(mockPhoto.photoURL)
        XCTAssertEqual(mockPhoto.photoURL, expectedURL)

    }

    // MARK: - BuddyIconable Tests
    
    struct MockBuddyIcon: BuddyIconable {
        var iconserver: String
        var owner: String
    }

    func testBuddyIconableIconURL() {
        let mockBuddyIcon = MockBuddyIcon(iconserver: "123", owner: "owner")
        let expectedURL = URL(string: "https://live.staticflickr.com/123/buddyicons/owner_r.jpg")

        XCTAssertNotNil(mockBuddyIcon.iconURL)
        XCTAssertEqual(mockBuddyIcon.iconURL, expectedURL)
    }
    
    func testBuddyIconableWhenServerZeroShouldReturnPlaceholderURL() {
        let mockBuddyIcon = MockBuddyIcon(iconserver: "0", owner: "owner")
        let expectedURL = URL(string: "https://www.flickr.com/images/buddyicon.gif")

        XCTAssertNotNil(mockBuddyIcon.iconURL)
        XCTAssertEqual(mockBuddyIcon.iconURL, expectedURL)
    }

    // MARK: - CoverPhotable Tests
    
    struct MockCoverPhoto: CoverPhotable {
        var iconfarm: Int
        var iconserver: String
        var id: String
    }

    func testCoverPhotableCoverURL() {
        let mockCoverPhoto = MockCoverPhoto(iconfarm: 1, iconserver: "server", id: "id")
        let expectedURL = URL(string: "https://farm1.staticflickr.com/server/coverphoto/id_h.jpg")

        XCTAssertNotNil(mockCoverPhoto.coverURL)
        XCTAssertEqual(mockCoverPhoto.coverURL, expectedURL)
    }
}
