//
//  ImagesListViewPresenter.swift
//  ImageFeed
//
//  Created by Максим Хоменков on 03.04.24.
//

import Foundation

protocol ImagesListViewPresenterProtocol: AnyObject {
    var view: ImagesListViewControllerProtocol? { get set}
    var photos: [Photo] { get set }
    func updateTable()
    func fetchPhotos()
}

final class ImagesListViewPresenter: ImagesListViewPresenterProtocol {
    private var imagesListService = ImagesListService.shared
    weak var view: ImagesListViewControllerProtocol?
    var photos: [Photo] = []
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    func updateTable() {
        let oldCount = photos.count
        let newCount = imagesListService.photos.count
        photos = imagesListService.photos
        if oldCount != newCount {
            view?.updateTableViewAnimated(oldCount: oldCount, newCount: newCount)
        }
    }
    
    func fetchPhotos() {
        imagesListService.fetchPhotosNextPage()
    }
}
