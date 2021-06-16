//
//  FriendsTableViewController.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    
    var friends = [ User(avatar: UIImage(named: "man1"), name: "Ricardo", surname: "Milos", myPhotos: [UIImage(named: "ricardo1"), UIImage(named: "ricardo2"), UIImage(named: "ricardo3")]),
                    User(avatar: UIImage(named: "man2"), name: "Jason", surname: "Stathem", myPhotos: [UIImage(named: "jason1"), UIImage(named: "jason2"), UIImage(named: "jason3")]),
                    User(avatar: UIImage(named: "man3"), name: "Mike", surname: "White", myPhotos: [UIImage(named: "peppa1"), UIImage(named: "peppa2"), UIImage(named: "peppa3")])
                  ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  navigationController?.delegate = self   //Необходим для анимаций переходов между контроллерами
    }

    // MARK: - Table view data source

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

    //MARK: - Метод добавляет аватар пользователя и его фотки в коллекцию картинок -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard
        segue.identifier == "fromFriendViewToPhotos",
        let photoCollection = segue.destination as? FriendsCollectionViewController,
        let indexPath = tableView.indexPathForSelectedRow?.section
       else { return }
        photoCollection.photos.append(friends[indexPath].avatar)
        photoCollection.photos.append(contentsOf: friends[indexPath].myPhotos)
        photoCollection.title = friends[indexPath].fullName

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
//MARK: - Метод, который выцепляет все уникальные буквы из массива и добавляет их в новый массив -
    func arrayLetter() -> [String] {
        var resultArray = [String]()
        
        for item in friends {
            let nameLetter = String(item.name.prefix(1))
            if !resultArray.contains(nameLetter) {
                resultArray.append(nameLetter)
            }
        }
        return resultArray
    }
    
    //MARK: - Метод, формирующий массив из первых букв имен в массиве friends -
    func arrayByLetter(letter: String) -> [User] {
        var resultArray = [User]()
        
        for item in friends {
            let nameLetter = String(item.name.prefix(1))
            
            if nameLetter == letter {
                resultArray.append(item)
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


