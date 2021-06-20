//
//  User.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//

import UIKit

struct User {
    let avatar: UIImage?
    let name: String
    let surname: String
    var fullName: String { "\(name) \(surname)"}
    
    let myPhotos: [UIImage?]
   
}
