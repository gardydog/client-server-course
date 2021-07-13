//
//  User.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//

import UIKit
import RealmSwift

// MARK: - Friends
struct Friends: Codable {
    let response: UserResponseCodable
}

// MARK: - Response
struct UserResponseCodable: Codable {
    let count: Int
    let items: [UserItemsCodable]
}

// MARK: - Item
class UserItemsCodable: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var lastName: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var avatar: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case firstName = "first_name"
        case avatar = "photo_50"
    }
    
    func getFullName() -> String {
        return "\(firstName) \(lastName)"
    }
}
