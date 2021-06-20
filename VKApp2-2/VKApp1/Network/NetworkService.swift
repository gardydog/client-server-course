//
//  NetworkService.swift
//  VKApp1
//
//  Created by Mac on 20.06.2021.
//

import Foundation
import Alamofire

class NetworkService {
    
    static let session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        let session = Alamofire.Session(configuration: configuration)
        return session
    }()
    
    static func loadGroups(token: String) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.131"
        ]
        
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            guard let json = response.value else { return }
            
            print(json)
        }
    }
    
    static func loadFriends(token: String) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.131"
        ]
        
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            guard let json = response.value else { return }
            
            print(json)
        }
    }
    
    static func loadFriendsPhotos(token: String) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/photos.getAll"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.131"
        ]
        
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            guard let json = response.value else { return }
            
            print(json)
        }
    }
    
    static func groupsSearch(token: String) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "q": "Smart",           //Текст поискового запроса
            "type": "group",        //Тип сообщества. Возможные значения: group, page, event
            //"count": 2,  //Количество выводимых в консоль результатов, перестаёт работать "type", если включить
            "access_token": token,
            "extended": 1,
            "v": "5.131"
        ]
        
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            guard let json = response.value else { return }
            
            print(json)
        }
    }
    
    
}
