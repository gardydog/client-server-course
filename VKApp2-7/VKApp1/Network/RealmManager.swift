//
//  RealmManager.swift
//  VKApp1
//
//  Created by Mac on 05.07.2021.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
    func add(models: [Object])
    func read(object: Object.Type) -> [Object]
    func read(object: Object.Type, filter: String) -> [Object]
    func delete(model: Object)
}

class RealmManager: RealmManagerProtocol {

    let config = Realm.Configuration(schemaVersion: 1)
    lazy var realm = try! Realm(configuration: config)
    
    //MARK: - Major methods
    //Метод добавляет пользователя (объект)
    func add(models: [Object]) {
        do {
            self.realm.beginWrite()
            self.realm.add(models, update: .modified)
            try self.realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //Метод добавляет свойства объектов
    func read(object: Object.Type) -> [Object] {
        let models = realm.objects(object)

        return Array(models)
    }
    
    func read(object: Object.Type, filter: String) -> [Object] {
        let models = realm.objects(object).filter(filter)

        return Array(models)
    }

    //Удаляет один объект
    func delete(model: Object) {
        do {
            self.realm.beginWrite()
            self.realm.delete(model)
            try self.realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error.localizedDescription)
        }
    }
}

