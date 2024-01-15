//
//  UserDetailViewModelTests.swift
//  FlickrTests
//
//  Created by William de Alvelos on 14/01/2024.
//

import XCTest
import Combine
@testable import Flickr

final class UserDetailViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    private let timeout = 10.0
    
    var viewModel: UserDetailViewModel!
    var repository: FakeFlickrRepository!
    
    override func setUp() {
        super.setUp()
        repository = FakeFlickrRepository()
        viewModel = UserDetailViewModel(repository: repository, userId: "mocked userId")
    }
    
    override func tearDown() {
        viewModel = nil
        repository = nil
        super.tearDown()
    }
    
    func testLoadUserProfileAndPhotosShouldSuccess() throws {
        let mockedPerson = PersonFactory.new()
        repository.mockedPhotos = [PhotoFactory.new(id: "1")]
        repository.mockedPerson = mockedPerson

        repository.shouldThrowError = false
        
        let expectation = XCTestExpectation(description: "Load photos expectation")
        
        viewModel.fetchPhotosAndUserDetails()
        
        viewModel.$status.sink { status in
            guard status != .loading else { return }
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeout)
        
        XCTAssertEqual(viewModel.photos.count, 1)
        XCTAssertNotNil(viewModel.person)
        XCTAssertEqual(viewModel.person!.id, mockedPerson.id)
        XCTAssertEqual(viewModel.status, .loaded)
    }
    
    func testLoadUserProfileAndPhotosPageEmpty() throws {
        let mockedPerson = PersonFactory.new()
        repository.mockedPhotos = []
        repository.mockedPerson = mockedPerson
        repository.shouldThrowError = false
        
        let expectation = XCTestExpectation(description: "Load photos expectation")
        
        viewModel.fetchPhotosAndUserDetails()
        
        viewModel.$status.sink { status in
            print(status)
            guard status != .loading else { return }
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeout)
        
        XCTAssertEqual(viewModel.photos.count, 0)
        XCTAssertNotNil(viewModel.person)
        XCTAssertEqual(viewModel.person!.id, mockedPerson.id)
        XCTAssertEqual(viewModel.status, .empty)
    }
    
    func testLoadUserProfileAndPageWithError() throws {
        repository.shouldThrowError = true
        
        let expectation = XCTestExpectation(description: "Load photos expectation")
        
        viewModel.fetchPhotosAndUserDetails()
        
        viewModel.$status.sink { status in
            guard status != .loading else { return }
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeout)
        
        XCTAssertEqual(viewModel.photos.count, 0)
        XCTAssertEqual(viewModel.status, .error(error: repository.mockedError))
    }
}
