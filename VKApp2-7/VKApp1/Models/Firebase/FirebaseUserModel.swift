//
//  FirebaseUserModel.swift
//  VKApp1
//
//  Created by Mac on 14.07.2021.
//

import Foundation
import Firebase

class FirebaseUserModel {
    let id: String
    let ref: DatabaseReference?     //Ссылка на нашу базу данных в firebase
    
    init(id: String) {
        self.ref = nil
        self.id = id
    }
    
    //"Выскальзывающий" инит. Snapshot - это dictionary, в котором мы храним данные
    init?(snapshot: DataSnapshot) {     //https://firebase.google.com/docs/reference/android/com/google/firebase/database/DataSnapshot
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? String
        else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.id = id
    }
    //Трансформируем в dictionary в этом месте
    func toAnyObject() -> [String: Any] {
        return [
            "id": id
        ]
    }
}


