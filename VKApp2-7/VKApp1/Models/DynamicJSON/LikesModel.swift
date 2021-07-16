//
//  LikesModel.swift
//  VKApp1
//
//  Created by Mac on 02.07.2021.
//

import Foundation
import DynamicJSON

class LikesModel: BaseObject {

    var count: Int?
    var userLikes: Int?

    convenience required init(data: JSON) {
        self.init()

        self.userLikes = data.user_likes.int
        self.count = data.count.int
    }
}
