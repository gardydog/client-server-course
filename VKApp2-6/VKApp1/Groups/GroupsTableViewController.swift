//
//  GroupsTableViewController.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var mySearchBar: UISearchBar!
    
    let groupsID = "GroupsTableViewCell"
    let networkservice = NetworkService()
    let realmManager = RealmManager()
    
    var searchFlag = false
    
//    var searchGroupsArray = [GroupsItemsCodable]()
    var groups = [GroupModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGroups()
        
//        searchGroupsArray = groups
        tableView.reloadData()
        
        mySearchBar.delegate = self
    }
    
    func setGroups() {
        networkservice.loadGroups(by: nil) { [weak self] in
            guard let self = self else { return }
            
            if let groups = self.realmManager.read(object: GroupModel.self) as? [GroupModel] {
                self.groups = groups
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: groupsID, for: indexPath) as? GroupsTableViewCell
        else { return UITableViewCell() }
            
        let group = groups[indexPath.row]        //Отображаем именно этот array
        cell.configure(group: group)

        return cell
    }
    
//MARK: - Функция1, добавляющая группы в текущий контроллер -
    @IBAction func addGroup(segue: UIStoryboardSegue) {
    
        if segue.identifier == "addGroup" {
            guard let allGroups = segue.source as? ExtraGroupsTableViewController else { return }
            
            if let indexPath = allGroups.tableView.indexPathForSelectedRow {
                let group = allGroups.extraGroups[indexPath.row]
                
                if !groups.contains(group) {
                    groups.append(group)
                    //searchGroupsArray = groups
                    tableView.reloadData()
                }
            }
        }
    }
    
//MARK: - Функция, удаляющая группы из контроллера -
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
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
        
}

//MARK: - Метод, позволяющий искать похожие буквы -
extension GroupsTableViewController {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            networkservice.groupsSearch(searchText: searchText) { groups in
                self.groups = groups
                self.tableView.reloadData()
            }
        }
    }
}

