//
//  ExtraGroupsTableViewController.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//

import UIKit

class ExtraGroupsTableViewController: UITableViewController {

    let groupsID = "GroupsTableViewCell"
    
    var extraGroups = [Group(avatar: UIImage(named: "sport1"), name: "HardWeight"),
                  Group(avatar: UIImage(named: "sport2"), name: "Football"),
                  Group(avatar: UIImage(named: "sport3"), name: "Runnig"),
                  Group(avatar: UIImage(named: "logo1"), name: "MDK"),
                  Group(avatar: UIImage(named: "logo2"), name: "News")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return extraGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: groupsID, for: indexPath) as? GroupsTableViewCell
        else { return UITableViewCell() }
            
        let group = extraGroups[indexPath.row]
        cell.configure(image: group.avatar, name: group.name)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
