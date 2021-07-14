//
//  ExtraGroupsTableViewController.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//

import UIKit

class ExtraGroupsTableViewController: UITableViewController {

    @IBOutlet weak var searchExtraGroups: UISearchBar!
    
    let groupsID = "GroupsTableViewCell"
    let networkservice = NetworkService()
    
    var extraGroups = [GroupModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchExtraGroups.delegate = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return extraGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: groupsID, for: indexPath) as? GroupsTableViewCell
        else { return UITableViewCell() }
            
        let group = extraGroups[indexPath.row]
        cell.configure(group: group)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ExtraGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            networkservice.groupsSearch(searchText: searchText) { groups in
                self.extraGroups = groups
                self.tableView.reloadData()
            }
        }
    }
}
