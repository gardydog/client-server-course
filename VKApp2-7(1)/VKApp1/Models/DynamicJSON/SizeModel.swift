//
//  SizeModel.swift
//  VKApp1
//
//  Created by Mac on 02.07.2021.
//

import Foundation
import DynamicJSON

class SizeModel: BaseObject {

    var url: String?
    var type: String?

    convenience required init(data: JSON) {
        self.init()

        self.url = data.url.string
        self.type = data.type.string
    }
}
