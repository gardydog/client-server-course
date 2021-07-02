//
//  User.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//

import UIKit
import RealmSwift

//Структура для использования приложения без подключения к интернету (Тестовая)
//struct User {
//    let avatar: UIImage?
//    let name: String
//    let surname: String
//    var fullName: String { "\(name) \(surname)"}
//
//    let myPhotos: [UIImage?]
//
//}

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
    @objc dynamic var id: Int
    @objc dynamic var lastName: String
    @objc dynamic var firstName: String
    @objc dynamic var avatar: String

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
