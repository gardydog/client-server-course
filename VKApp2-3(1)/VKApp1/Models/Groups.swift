//
//  Groups.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//
//lalalalala
import UIKit

//Структура для использования приложения без подключения к интернету (Тестовая)
struct Group: Equatable {
    let avatar: UIImage?
    let name: String
}

// MARK: - Welcome
struct Groups: Codable {
    let response: UserGroupsResponseCodable
}

// MARK: - Response
struct UserGroupsResponseCodable: Codable {
    let count: Int
    let items: [GroupsItemsCodable]
}

// MARK: - Item
struct GroupsItemsCodable: Codable {
    let id: Int
    let name: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_50"
    }
}

extension GroupsItemsCodable: Equatable {
    static func == (lhs: GroupsItemsCodable, rhs: GroupsItemsCodable) -> Bool {
        return lhs.name == rhs.name
    }
}
