//
//  VKLoginController.swift
//  VKApp1
//
//  Created by Mac on 20.06.2021.
//

import UIKit
import WebKit
import SwiftKeychainWrapper

class VKLoginController: UIViewController {
    
    let networkservice = NetworkService()
    let fromLoginToTabBar = "fromLoginToTabBar"

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorizeToVK()
    }
    
    func authorizeToVK() {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7884481"), //ID приложения, смотрим в настройках
            URLQueryItem(name: "scope", value: "262150"), // "https://vk.com/dev/implicit_flow_user"
            URLQueryItem(name: "display", value: "mobile"), // авторизация для мобильных устройств
            URLQueryItem(name: "redirect_uri", value: "https://ouath.vk.com/blank.html"), // Адрес, на который будет переадресован пользователь после прохождения авторизации
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"), //Вызывает окно подтверждения входа всегда
            URLQueryItem(name: "v", value: "5.131") //Версия API, можно посмотреть акутальную, вбив: "текущая версия vk"
        ]
        
        let request = URLRequest(url: components.url!)
        webView.load(request)
    }
}

extension VKLoginController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",    //Отлавливаем ту страницу, на которую мы переходим
              let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        //Парсим токен, который к нам пришел в 44-ой строчке
        let params = fragment
            .components(separatedBy: "&")   //Разделяем компоненты амперсентом "&"
            .map { $0.components(separatedBy: "=") }    //Сами ключи разделяются знаком "="
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict     //На выходе получаем словарь, где получается: [Ключ : Значение]
            }
        //print(params) //Выводим в консоль этот словарь
        
        //В ответе приходит токен, который мы выдергиваем и сохраняем
        guard let token = params["access_token"],
              let userIdString = params["user_id"] else {
            decisionHandler(.allow)
            return
        }
        //Организуем хранилище данных двумя разными способами:
        KeychainWrapper.standard.set(token, forKey: "token")
        Session.shared.token = token

        UserDefaults.standard.set(userIdString, forKey: "userIdString")
        Session.shared.userId = userIdString
        

          Session.shared.token = token //Сохраняем наш токен в тот токен, который мы создали в классе синглтона
          Session.shared.userId = userIdString
              
              performSegue(withIdentifier: fromLoginToTabBar, sender: nil) //Функция перехода с главного экарана на другие
        
        decisionHandler(.cancel)
//        networkservice.loadFriends { users in print("loadFriends") }    //Выводим список друзей
//        networkservice.loadFriendsPhotos { usersPhotos in print("loadFriendsPhotos") }//Выводим список фотографий пользователя
//        networkservice.loadGroups { groups in print("loadGroups") }    //Выводим список групп
//        networkservice.groupsSearch { groups in print("groupsSearch") }   //Осуществляем поиск по группам пользователя
  
    }
}
