//
//  File.swift
//  VKApp1
//
//  Created by Mac on 02.07.2021.
//

import RealmSwift
import DynamicJSON

public class BaseObject: Object {

    convenience required init(data: JSON) {
        self.init()
    }
}
