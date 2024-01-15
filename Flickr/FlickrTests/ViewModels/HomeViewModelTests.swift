//
//  HomeViewModelTests.swift
//  FlickrTests
//
//  Created by William de Alvelos on 12/01/2024.
//

import XCTest
import Combine
@testable import Flickr

final class HomeViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    private let timeout = 10.0
    var viewModel: HomeViewModel!
    var repository: FakeFlickrRepository!
    var coordinator: FakeHomeViewCoordinator!
    
    override func setUp() {
        super.setUp()
        repository = FakeFlickrRepository()
        coordinator = FakeHomeViewCoordinator()
        viewModel = HomeViewModel(repository: repository, coordinator: coordinator)
    }
    
    override func tearDown() {
        viewModel = nil
        repository = nil
        coordinator = nil
        super.tearDown()
    }

    
    func testCoordinatorShouldHavePhotoAfterPresenter() {
        let photo = PhotoFactory.new()
        XCTAssertNil(coordinator.didPresentPhoto)
        viewModel.presentPhoto(photo: photo)
        XCTAssertEqual(coordinator.didPresentPhoto, photo)
    }
    
    func testCoordinatorShouldHaveOwnerAfterPresenter() {
        let owner = "William Alvelos"
        XCTAssertNil(coordinator.didPresentOwner)
        viewModel.presentUserProfile(owner: owner)
        XCTAssertEqual(coordinator.didPresentOwner, owner)
    }
    
    func testInitialSearchTextIsYorkshire() {
        XCTAssertEqual(viewModel.searchText, "yorkshire")
    }
    
    func testLoadFirstPageSuccess() throws {
        repository.mockedPhotos = [PhotoFactory.new(id: "1")]
        repository.shouldThrowError = false
        
        let expectation = XCTestExpectation(description: "Load photos expectation")
        
        viewModel.loadFirstPage()
        viewModel.$status.sink { status in
            guard status != .loading else { return }
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeout)
        
        XCTAssertEqual(viewModel.photos.count, 1)
        XCTAssertEqual(viewModel.status, .loaded)
    }
    
    func testLoadFirstPageEmpty() throws {
        repository.mockedPhotos = []
        repository.shouldThrowError = false
        
        let expectation = XCTestExpectation(description: "Load photos expectation")
        
        viewModel.loadFirstPage()
        
        viewModel.$status.sink { status in
            print(status)
            guard status != .loading else { return }
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeout)
        
        XCTAssertEqual(viewModel.photos.count, 0)
        XCTAssertEqual(viewModel.status, .empty)
    }
    
    func testLoadFirstPageError() throws {
        repository.shouldThrowError = true
        
        let expectation = XCTestExpectation(description: "Load photos expectation")
        
        viewModel.loadFirstPage()
        
        viewModel.$status.sink { status in
            print(status)
            guard status != .loading else { return }
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeout)
        
        XCTAssertEqual(viewModel.photos.count, 0)
        XCTAssertEqual(viewModel.status, .error(error: repository.mockedError))
    }
}

// MARK: FakeHomeViewCoordinator

class FakeHomeViewCoordinator: HomeViewWireframe {
    
    var didPresentPhoto: Photo?
    var didPresentOwner: String?
    
    func presentPhoto(photo: Photo) {
        didPresentPhoto = photo
    }
    
    func presentUserProfile(owner: String) {
        didPresentOwner = owner
    }
}
