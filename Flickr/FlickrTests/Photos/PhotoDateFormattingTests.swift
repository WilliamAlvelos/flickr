//
//  PhotoDateFormattingTests.swift
//  FlickrTests
//
//  Created by William de Alvelos on 14/01/2024.
//

@testable import Flickr
import XCTest

class DateFormattingTests: XCTestCase {

    func testPhotoFormattingShouldMatch() {
        let validDateString = "2023-12-31 08:30:00"
        let photo = PhotoFactory.new(datetaken: validDateString)
        
        XCTAssertEqual(photo.dateTakesFormated, "December 31, 2023")
    }
    
    func testPhotoInvalidDateReturnsDateWithoutFormatting() {
        let invalidDateString = "Invalid Date"
        let photo = PhotoFactory.new(datetaken: invalidDateString)

        XCTAssertEqual(photo.dateTakesFormated, invalidDateString)
    }
}
