//
//  GroupsTableViewController.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var mySearchBar: UISearchBar!
    
    let groupsID = "GroupsTableViewCell"
    let networkservice = NetworkService()
    let realmManager = RealmManager()
    
    var searchFlag = false

    var token: NotificationToken?
    
    var groups: Results<GroupModel>? {
        didSet {
            token = groups?.observe { [weak self] changes in
                guard let self = self else { return }
                
                switch changes {
                case .initial:
                    self.tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    self.tableView.beginUpdates()   //Такая конструкция заменяет обычный метод ReloadData() (от Евгения)
                    self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                    self.tableView.endUpdates()
                case .error(let error):
                    fatalError("\(error)")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGroups()
      
        tableView.reloadData()
        
        mySearchBar.delegate = self
    }
    
    func setGroups() {
        networkservice.loadGroups(by: nil)
            
        guard let realm = try? Realm() else { return }
        groups = realm.objects(GroupModel.self)
        
        }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return groups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: groupsID, for: indexPath) as? GroupsTableViewCell
        else { return UITableViewCell() }
            
        if let group = groups?[indexPath.row] {   //Отображаем именно этот array
        cell.configure(group: group)
        }
        
        return cell
    }
    
//MARK: - Функция1, добавляющая группы в текущий контроллер -
    @IBAction func addGroup(segue: UIStoryboardSegue) {
    
        if segue.identifier == "addGroup" {
            guard let allGroups = segue.source as? ExtraGroupsTableViewController else { return }
            
            if let indexPath = allGroups.tableView.indexPathForSelectedRow {
                let group = allGroups.extraGroups[indexPath.row]
                
                realmManager.add(models: [group])
            }
        }
    }
    
//MARK: - Функция, удаляющая группы из контроллера -
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
        if let group = groups?[indexPath.row],
           editingStyle == .delete {
            realmManager.delete(model: group)
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

//MARK: - Метод, позволяющий искать похожие буквы - (Нужно добавить метод поиска в RealmManager и сюда поставить вместо groupsSearch TO-DO)
//extension GroupsTableViewController {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if !searchText.isEmpty {
//            networkservice.groupsSearch(searchText: searchText) { groups in
//                self.groups = groups
//                self.tableView.reloadData()
//            }
//        }
//    }
//}

