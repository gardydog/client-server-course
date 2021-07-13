//
//  GroupsTableViewCell.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    func clearCell() {
        groupImage.image = nil
        groupNameLabel.text = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    func configure(group: GroupModel) {
        groupNameLabel.text = group.name
        groupImage.sd_setImage(with: URL(string: group.avatar), placeholderImage: UIImage(named: "glasses"))
    }
}
