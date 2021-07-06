//
//  Data+PrettyJSON.swift
//  VKApp1
//
//  Created by Mac on 24.06.2021.
//

import Foundation

//Данное расширение позволяет перевести данные в JSON-формат
extension Data {
    var prettyJSON: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            return nil }
     
        return prettyPrintedString
    }
}
