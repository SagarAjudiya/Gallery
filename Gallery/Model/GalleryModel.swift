//
//  GalleryModel.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 11/05/24.
//

import Foundation

struct GalleryResponse: Codable {
    var total, totalHits: Int?
    var hits: [Hit]?
}

// MARK: - Hit
struct Hit: Codable {
    var id: Int?
    var pageURL: String?
    var type: String?
    var tags: String?
    var previewURL: String?
    var previewWidth, previewHeight: Int?
    var webformatURL: String?
    var webformatWidth, webformatHeight: Int?
    var largeImageURL: String?
    var imageWidth, imageHeight, imageSize, views: Int?
    var downloads, collections, likes, comments: Int?
    var userID: Int?
    var user: String?
    var userImageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, imageWidth, imageHeight, imageSize, views, downloads, collections, likes, comments
        case userID = "user_id"
        case user, userImageURL
    }
}

class GalleryRequest: Codable {
    var key = "43830858-6be145f2983ce27ed6d3ef30d"
    var page = 1
}
