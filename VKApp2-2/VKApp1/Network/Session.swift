//
//  Session.swift
//  VKApp1
//
//  Created by Mac on 20.06.2021.
//

import Foundation

final class Session {
    
    var token = ""  //– для хранения токена в VK,
    var userId = Int()   //– для хранения идентификатора пользователя ВК.
    
    static let shared = Session()
    private init() {}
}
