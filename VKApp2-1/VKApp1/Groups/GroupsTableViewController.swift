//
//  GroupsTableViewController.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var mySearchBar: UISearchBar!
    
    var searchFlag = false
    
    let groupsID = "GroupsTableViewCell"
    
    var searchGroupsArray = [Group]()
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let mdk = Group(avatar: UIImage(named: "logo1"), name: "MDK")
        let news = Group(avatar: UIImage(named: "logo2"), name: "News")
//        let hardSport = Group(avatar: UIImage(named: "sport1"), name: "HardWeight")
//        let footballSport = Group(avatar: UIImage(named: "sport2"), name: "Football")
//        let runSport = Group(avatar: UIImage(named: "sport3"), name: "Runnig")
        
//        searchGroupsArray.append(mdk)
//        searchGroupsArray.append(news)
        
        groups.append(mdk)
        groups.append(news)
//        groups.append(hardSport)
//        groups.append(footballSport)
//        groups.append(runSport)
        
        searchGroupsArray = groups
        tableView.reloadData()
        
        mySearchBar.delegate = self
    }

    //Если поиск активен, то возвращает только нужные группы, если не активен, то возвращает массив
    //(По-моему, бесполезная функция)
    func myGroupsArray() -> [Group] {
        
        if searchFlag {
            return searchGroupsArray
        }
        return groups
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return searchGroupsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: groupsID, for: indexPath) as? GroupsTableViewCell
        else { return UITableViewCell() }
            
        let group = searchGroupsArray[indexPath.row]        //Отображаем именно этот array
        cell.configure(image: group.avatar, name: group.name)

        return cell
    }
    
//MARK: - Функция1, добавляющая группы в текущий контроллер -
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addGroup",
            let allGroups = segue.source as? ExtraGroupsTableViewController,
            let indexPath = allGroups.tableView.indexPathForSelectedRow

        else { return }

        let group = allGroups.extraGroups[indexPath.row]
        if !groups.contains(group) {
            groups.append(group)
            searchGroupsArray = groups  //Нужно добавить в оба массива, иначе некорретно
            tableView.reloadData()  //Обновляет таблицу, куда добавляю группу (важная)
        }
    }
    
//MARK: - Функция, удаляющая группы из контроллера -
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            searchGroupsArray.remove(at: indexPath.row) //Обязательно удаляем в обоих массивах, иначе некорретная работа
            tableView.deleteRows(at: [indexPath], with: .fade)

        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    //Логика функции1 выше:
//    1) Проверить что сега именно та которая нужна +
//    2) взять контроллер на который будет добавленна группа +
//    3) взять индекс нажатой ячейки -
//    4) взять группу которую нужно добавить -
//    5) проверить есть ли такая группа там куда хочу добавить -
//    6) если нет такой группы то добавить ее -
//    7) обновить таблицу в контроллере куда добавляю группу -
        
    //MARK: - Метод, позволяющий искать похожие буквы -
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                searchFlag = false
                searchGroupsArray = groups
            }
            else {
                searchFlag = true
                searchGroupsArray = groups.filter({ item in
                    item.name.lowercased().contains(searchText.lowercased())
                })
            }
            tableView.reloadData()
        }
    
    
    
}
    

