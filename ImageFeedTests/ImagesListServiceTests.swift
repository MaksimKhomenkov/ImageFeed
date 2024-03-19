//
//  ImageFeedTests.swift
//  ImageFeedTests
//
//  Created by Максим Хоменков on 19.03.24.
//
@testable import ImageFeed
import XCTest

final class ImagesListServiceTests: XCTestCase {
    func testExample() {
    }
    
    func testFetchPhotos() {
        let service = ImagesListService()
        
        let expectation = self.expectation(description: "Wait for Notification")
        NotificationCenter.default.addObserver(
            forName: ImagesListService.didChangeNotification,
            object: nil,
            queue: .main) { _ in
                expectation.fulfill()
            }
        
        service.fetchPhotosNextPage()
        wait(for: [expectation], timeout: 10)
        
        XCTAssertEqual(service.photos.count, 10)
    }
}
