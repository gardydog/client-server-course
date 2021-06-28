//
//  Photos.swift
//  VKApp1
//
//  Created by Mac on 24.06.2021.
//

import UIKit

//Классы парсинга JSON

struct Photos: Codable {
    let response: UserPhotosResponseCodable
}

// MARK: - Response
struct UserPhotosResponseCodable: Codable {
    let count: Int
    let items: [PhotoItemsCodable]
}

// MARK: - Item
struct PhotoItemsCodable: Codable {
    let albumID, id, ownerID: Int
    let sizes: [Size]
    let likes: Likes

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id
        case ownerID = "owner_id"
        case sizes, likes
    }
}

//MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

//MARK: - Size
struct Size: Codable {
    let url: String
    let type: String
}
