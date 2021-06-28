//
//  User.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//

import UIKit

//Структура для использования приложения без подключения к интернету (Тестовая)
struct User {
    let avatar: UIImage?
    let name: String
    let surname: String
    var fullName: String { "\(name) \(surname)"}
    
    let myPhotos: [UIImage?]
   
}

struct Friends: Codable {
    let response: UserResponseCodable
}

// MARK: - Response
struct UserResponseCodable: Codable {
    let count: Int
    let items: [UserItemsCodable]
}

// MARK: - Item
struct UserItemsCodable: Codable {
    let id: Int
    let lastName: String
    let firstName: String
    let avatar: String

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
