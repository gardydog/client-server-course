//
//  Photos.swift
//  VKApp1
//
//  Created by Mac on 24.06.2021.
//

import UIKit
import RealmSwift

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
class PhotoItemsCodable: Object, Codable {
    @objc dynamic var albumID: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerID: Int = 0
    dynamic var sizes: [Size]
    dynamic var likes: Likes

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id
        case ownerID = "owner_id"
        case sizes, likes
    }
    
    //Позволяет игнорировать sizes и likes, так как Realm не обрабатыввет массивы и классы
    override static func ignoredProperties() -> [String] {
        return ["sizes", "likes"]
    }
}

//MARK: - Likes
class Likes: Object, Codable {
    @objc dynamic var userLikes: Int
    @objc dynamic var count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

//MARK: - Size
class Size: Object, Codable {
    @objc dynamic var url: String
    @objc dynamic var type: String
}
