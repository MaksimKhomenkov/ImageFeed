//
//  PhotoStruct.swift
//  ImageFeed
//
//  Created by Максим Хоменков on 19.03.24.
//

import Foundation

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool
}
