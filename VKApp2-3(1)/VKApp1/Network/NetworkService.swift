//
//  NetworkService.swift
//  VKApp1
//
//  Created by Mac on 20.06.2021.
//

import Foundation
import Alamofire

//Класс для работы с сетевыми запросами
 class NetworkService {
    //Свойство основной ссылки на API
      let baseURL: String = "https://api.vk.com/method/"
    //Свойство версии API
      let apiVersion: String = "5.131"
    //Свойство методов доступа к данным
      var method: Methods?
    
    //Перечисление методов доступа
    enum Methods: String {
        case groups = "groups.get"
        case friends = "friends.get"
        case photos = "photos.get"
        case groupsSearch = "groups.search"
    }
    
    //Перечисление типов альбомов с фото пользователей
    enum AlbumID: String {
        case wall = "wall"
        case profile = "profile"
        case saved = "saved"
    }
    
    //MARK: - Возвращает список идентификаторов друзей пользователя или расширенную информацию о друзьях пользователя (при использовании параметра fields) - https://vk.com/dev/friends.get
    func loadFriends(by userId: Int?, completion: @escaping([UserItemsCodable]) -> ()) {   //@escaping нужен, чтобы вызвать замыкание в другом месте (DispatchQueue.main.async)
        
        method = .friends
        var params: Parameters = [
            //"user_id": Session.shared.userId,
            "fields": "photo_50",  //Без этого работать не будет
            "access_token": Session.shared.token, //Обязательное поле
            //"order": "name",
            //"count": 3,
            "v": apiVersion
        ]
        
        if let userId = userId {
            params["user_id"] = userId
        }
        
        let url = baseURL + method!.rawValue
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.data else { return }
            // print(data.prettyJSON as Any)
            let friendsResponse = try? JSONDecoder().decode(Friends.self, from: data).response //Позволяет из бинарного файла превратить в объект
            guard let friends = friendsResponse?.items else { return }
            
            DispatchQueue.main.async {
            completion(friends)
            }
        }
    }
    
    //MARK: - Возвращает список фотографий в альбоме - https://vk.com/dev/photos.get
    func loadFriendsPhotos(by ownerId: Int, completion: @escaping([PhotoItemsCodable]) -> ()) {
        
         method = .photos
         let params: Parameters = [
            "user_id": ownerId,
            "extended": 1,
            "access_token": Session.shared.token,
            "album_id": AlbumID.profile,
             "rev": 1,
//            "count": 10,
             "v": apiVersion
         ]
        let url = baseURL + method!.rawValue
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.data else { return }
            let photosResponse = try? JSONDecoder().decode(Photos.self, from: data).response
            guard let photos = photosResponse?.items else { return }
            DispatchQueue.main.async {
            completion(photos)
            }
        }
     }
    
    // MARK: - Возвращает список сообществ указанного пользователя - https://vk.com/dev/groups.get
    func loadGroups(by userId: Int?, completion: @escaping([GroupsItemsCodable]) -> ()) {
        
        method = .groups
       var params: Parameters = [
//           "user_id": Session.shared.userId,
           "access_token": Session.shared.token,
           "extended": 1,
//           "fields": "country",
//           "count": 3,
           "v": apiVersion
       ]
        
        if let userId = userId {
            params["user_id"] = userId
        }
        
        let url = baseURL + method!.rawValue
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.data else { return }
            let groupsResponse = try? JSONDecoder().decode(Groups.self, from: data).response
            guard let groups = groupsResponse?.items else { return }
            DispatchQueue.main.async {
            completion(groups)
            }
         }
    }
    
    //MARK: - Осуществляет поиск сообществ по заданной подстроке - https://vk.com/dev/groups.search
    func groupsSearch(searchText: String, completion: @escaping ([GroupsItemsCodable]) -> ()) {

        method = .groupsSearch
            let params: Parameters = [
                "access_token": Session.shared.token,
                "q": searchText,           //Текст поискового запроса
                //"type": "group",        //Тип сообщества. Возможные значения: group, page, event
                "count": 10,  //Количество выводимых в консоль результатов, перестаёт работать "type", если включить
                //"extended": 1,
                "v": apiVersion
            ]
        
        let url = baseURL + method!.rawValue
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.value else { return }
            let groupsResponse = try? JSONDecoder().decode(Groups.self, from: data).response
            guard let groups = groupsResponse?.items else { return }
            DispatchQueue.main.async {
                completion(groups)
            }
         }
    }
    
}
    
   
