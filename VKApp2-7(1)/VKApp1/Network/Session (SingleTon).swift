//
//  Session.swift
//  VKApp1
//
//  Created by Mac on 20.06.2021.
//

import Foundation

final class Session {
    
    static let shared = Session()
    
    private init() {}
    
    var token: String = ""  //– для хранения токена в VK,
    var userId: String = ""  //– для хранения идентификатора пользователя ВК.
}
