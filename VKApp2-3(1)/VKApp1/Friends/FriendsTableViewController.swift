//
//  FriendsTableViewController.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    let networkservice = NetworkService()
    
    var friends = [UserItemsCodable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFriends()
        
      //  navigationController?.delegate = self   //Необходим для анимаций переходов между контроллерами
    }

    // MARK: - Table view data source

    func setFriends() {
        networkservice.loadFriends(by: nil) { friends in
            self.friends = friends
            self.tableView.reloadData()
        }
    }
    
    //Выдает столько секций, сколько у нас уникальных букв
    override func numberOfSections(in tableView: UITableView) -> Int {
        return arrayLetter().count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayByLetter(letter: arrayLetter()[section]).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell", for: indexPath) as? FriendsTableViewCell
        else { return UITableViewCell() }

        let arrayByLetterItems = arrayByLetter(letter: arrayLetter()[indexPath.section])
        
        cell.configure(user: arrayByLetterItems[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "fromFriendViewToPhotos", sender: indexPath)
    }

    //MARK: - Метод добавляет аватар пользователя и его фотки в коллекцию картинок -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard
        segue.identifier == "fromFriendViewToPhotos",
        let photoCollection = segue.destination as? FriendsCollectionViewController
       else { return }

        guard let indexPath = sender as? IndexPath else { return }
        let friend = arrayByLetter(letter: arrayLetter()[indexPath.section])[indexPath.row]

        photoCollection.friendId = friend.id
    }
    
//MARK: - Метод, который выцепляет все уникальные буквы из массива и добавляет их в новый массив -
    func arrayLetter() -> [String] {
        var resultArray = [String]()
        
        for friend in friends {
            let nameLetter = String(friend.getFullName().prefix(1))
            if !resultArray.contains(nameLetter) {
                resultArray.append(nameLetter)
            }
        }
        resultArray = resultArray.sorted(by: <)     //Позволяет отсортировать друзей по убыванию
        
        return resultArray
    }
    
    //MARK: - Метод, формирующий массив из первых букв имен в массиве friends -
    func arrayByLetter(letter: String) -> [UserItemsCodable] {
        var resultArray = [UserItemsCodable]()
        
        for friend in friends {
            let nameLetter = String(friend.getFullName().prefix(1))
            if nameLetter == letter {
                resultArray.append(friend)
            }
        }
        return resultArray
    }

    //MARK: - Метод выдаёт нам первую букву имени в Header -
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayLetter()[section].uppercased()
    }
    
    //Метод, который позволяет кастить Header-ы
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//        {
//            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
//            if (section == 1) {
//                headerView.backgroundColor = UIColor.red
//            } else {
//                headerView.backgroundColor = UIColor.clear
//            }
//            return headerView
//        }

    }
    
