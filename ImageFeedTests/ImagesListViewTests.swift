//
//  ImagesListViewTests.swift
//  ImageFeedTests
//
//  Created by Максим Хоменков on 04.04.24.
//

@testable import ImageFeed
import XCTest

final class ImagesListViewTests: XCTestCase {
    
    func testViewControllerCallsFetchPhotos() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        let presenter = ImagesListViewPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        
        //when
        _ = viewController.view
        
        //then
        XCTAssertTrue(presenter.fetchPhotosCalled)
    }
}

final class ImagesListViewPresenterSpy: ImagesListViewPresenterProtocol {
    
    var photos: [Photo] = []
    var fetchPhotosCalled: Bool = false
    var view: ImagesListViewControllerProtocol?
    
    func updateTable() {
        
    }
    
    func fetchPhotos() {
        fetchPhotosCalled = true
    }
}
