//
//  Groups.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//
//lalalalala
import UIKit
import RealmSwift

//Структура для использования приложения без подключения к интернету (Тестовая)
//struct Group: Equatable {
//    let avatar: UIImage?
//    let name: String
//}

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
class GroupsItemsCodable: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_50"
    }
    
    override public func isEqual(_ object: Any?) -> Bool {
        
        if let other = object as? GroupsItemsCodable {
            return self.id == other.id
        }
        return false
    }

}
    

