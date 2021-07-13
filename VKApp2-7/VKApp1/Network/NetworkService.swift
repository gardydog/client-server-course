//
//  NetworkService.swift
//  VKApp1
//
//  Created by Mac on 20.06.2021.
//

import Foundation
import Alamofire
import DynamicJSON

//Класс для работы с сетевыми запросами
 class NetworkService {
    let realmManager = RealmManager()
    
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
    func loadFriends(by userId: Int?, completion: @escaping() -> ()) {
        
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
        
        AF.request(url, method: .get, parameters: params).responseData { [weak self] response in
            guard let self = self else { return }
            guard let data = response.data else { return }
            guard let items = JSON(data).response.items.array else { return }
            
            let friends = items.map { UserModel(data: $0) }
            
            self.realmManager.add(models: friends)
            
            completion()
        }
    }
    
    //MARK: - Возвращает список фотографий в альбоме - https://vk.com/dev/photos.get
    func loadFriendsPhotos(by ownerId: Int, completion: @escaping() -> ()) {
        
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
        
        AF.request(url, method: .get, parameters: params).responseData { [weak self] response in
            guard let self = self else { return }
            guard let data = response.data else { return }
            guard let items = JSON(data).response.items.array else { return }

            let photos = items.map { PhotoModel(data: $0) }
            
            self.realmManager.add(models: photos)
            
            completion()
        }
     }
    
    // MARK: - Возвращает список сообществ указанного пользователя - https://vk.com/dev/groups.get
    func loadGroups(by userId: Int?) {
        
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
        
        AF.request(url, method: .get, parameters: params).responseData { [weak self] response in
            guard let self = self else { return }
            guard let data = response.value else { return }
            guard let items = JSON(data).response.items.array else { return }

            let groups = items.map { GroupModel(data: $0) }
            
            self.realmManager.add(models: groups)
 
        }
    }
    
    //MARK: - Осуществляет поиск сообществ по заданной подстроке - https://vk.com/dev/groups.search
    func groupsSearch(searchText: String, completion: @escaping ([GroupModel]) -> ()) {

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
            guard let items = JSON(data).response.items.array else { return }

            let groups = items.map { GroupModel(data: $0) }
            
            DispatchQueue.main.async {
                completion(groups)
            }
         }
    }
    
}
    
   
