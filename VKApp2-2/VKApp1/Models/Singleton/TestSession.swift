//
//  Session.swift
//  VKApp1
//
//  Created by Mac on 16.06.2021.
//

import UIKit

final class TestSession {
    
    var token: String = "eyJ0gdhsX1d5"  //– для хранения токена в VK,
    var userId: Int = 12345    //– для хранения идентификатора пользователя ВК.
    
    static let shared = TestSession()
    
    private init() {}
}
