//
//  SafeSearchTests.swift
//  FlickrTests
//
//  Created by William de Alvelos on 14/01/2024.
//

import XCTest
@testable import Flickr

class SafeSearchTests: XCTestCase {

    func testSafeValueShouldBeOne() {
        XCTAssertEqual(SafeSearch.safe.rawValue, 1)
    }
    
    func testModerateValueShouldBeTwo() {
        XCTAssertEqual(SafeSearch.moderate.rawValue, 2)
    }
    
    func testRestrictedValueShouldBeThree() {
        XCTAssertEqual(SafeSearch.restricted.rawValue, 3)
    }

    func testInitWithRawValueShouldMatch() {
        XCTAssertEqual(SafeSearch(rawValue: 1), SafeSearch.safe)
        XCTAssertEqual(SafeSearch(rawValue: 2), SafeSearch.moderate)
        XCTAssertEqual(SafeSearch(rawValue: 3), SafeSearch.restricted)
    }
    
    func testInitWithRawValueNotExistentShouldBeNil() {
        XCTAssertNil(SafeSearch(rawValue: 4))
    }
}
