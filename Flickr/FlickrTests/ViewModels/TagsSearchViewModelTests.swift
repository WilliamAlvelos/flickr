//
//  SearchViewModelTests.swift
//  FlickrTests
//
//  Created by William de Alvelos on 14/01/2024.
//

import XCTest
import Combine
@testable import Flickr

final class TagsSearchViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    private let timeout = 10.0
    var viewModel: TagsSearchViewModel!
    var repository: FakeFlickrRepository!
    var coordinator: FakeSearchViewCoordinator!
    
    override func setUp() {
        super.setUp()
        repository = FakeFlickrRepository()
        coordinator = FakeSearchViewCoordinator()
        viewModel = TagsSearchViewModel(repository: repository, coordinator: coordinator)
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
        viewModel.presentPerson(person: owner)
        XCTAssertEqual(coordinator.didPresentOwner, owner)
    }
    
    func testCoordinatorShouldHaveGroupAfterPresenter() {
        let group = GroupFactory.new()
        XCTAssertNil(coordinator.didPresentGroup)
        viewModel.presentGroup(group: group)
        XCTAssertEqual(coordinator.didPresentGroup, group)
    }
    
    func testInitialPageIsOne() {
        XCTAssertEqual(viewModel.page.page, 1)
    }
    
    func testResetPageMethodShouldSetPageToOne() {
        XCTAssertEqual(viewModel.page.page, 1)
        
        viewModel.page.nextPage()
        XCTAssertEqual(viewModel.page.page, 2)
        
        viewModel.page.nextPage()
        XCTAssertEqual(viewModel.page.page, 3)
        
        viewModel.page.reset()
        XCTAssertEqual(viewModel.page.page, 1)
    }
    
    
    func testFetchingTheSecondPageShouldNotReturnEmpty() {
        repository.mockedPhotos = [PhotoFactory.new(id: "1")]
        repository.shouldThrowError = false
        
        let expectation = XCTestExpectation(description: "Load photos expectation")
        expectation.expectedFulfillmentCount = 2
        
        viewModel.search(text: "test")
        XCTAssertEqual(viewModel.page.page, 1)
        
        viewModel.$status.sink { status in
            guard status != .loading else { return }
            expectation.fulfill()
        }.store(in: &cancellables)
        
        
        repository.mockedPhotos = []
        repository.mockedPage.nextPage()
        viewModel.loadMoreIfNeeded()
        
        wait(for: [expectation], timeout: timeout)
        
        XCTAssertEqual(viewModel.status, .loaded)
    }
    
    
    func testLoadFirstPageSuccess() throws {
        repository.mockedPhotos = [PhotoFactory.new(id: "1")]
        repository.shouldThrowError = false
        
        let expectation = XCTestExpectation(description: "Load photos expectation")
        
        viewModel.search(text: "test")
        viewModel.$status.sink { status in
            guard status != .loading else { return }
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeout)
        
        XCTAssertEqual(viewModel.content.count, 1)
        XCTAssertEqual(viewModel.status, .loaded)
    }
    
    func testLoadFirstPageEmpty() throws {
        repository.mockedPhotos = []
        repository.shouldThrowError = false
        
        let expectation = XCTestExpectation(description: "Load photos expectation")
        
        viewModel.search(text: "test")
        
        viewModel.$status.sink { status in
            print(status)
            guard status != .loading else { return }
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeout)
        
        XCTAssertEqual(viewModel.content.count, 0)
        XCTAssertEqual(viewModel.status, .empty)
    }
    
    func testLoadFirstPageError() throws {
        repository.shouldThrowError = true
        
        let expectation = XCTestExpectation(description: "Load photos expectation")
        
        viewModel.search(text: "test")
        
        viewModel.$status.sink { status in
            guard status != .loading else { return }
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: timeout)
        
        XCTAssertEqual(viewModel.content.count, 0)
        XCTAssertEqual(viewModel.status, .error(error: repository.mockedError))
    }
    
    
    func testPaginationIsWorking() throws {
        XCTAssertFalse(viewModel.isLoadingNewPage)
        XCTAssertEqual(viewModel.page.page, 1)
        
        viewModel.loadMoreIfNeeded()
        
        XCTAssertTrue(viewModel.isLoadingNewPage)
        XCTAssertEqual(viewModel.page.page, 2)
        
        viewModel.loadMoreIfNeeded()
        
        // It must not fetch the next page if there a page loading
        XCTAssertTrue(viewModel.isLoadingNewPage)
        XCTAssertEqual(viewModel.page.page, 2)
    }
}

// MARK: FakeSearchViewCoordinator

class FakeSearchViewCoordinator: SearchViewWireframe {
    var didPresentPhoto: Photo?
    var didPresentOwner: String?
    var didPresentGroup: Group?
    
    func presentPhoto(photo: Photo) {
        didPresentPhoto = photo
    }
    
    func presentUserProfile(owner: String) {
        didPresentOwner = owner
    }
    
    func presentGroup(group: Group) {
        didPresentGroup = group
    }
}
