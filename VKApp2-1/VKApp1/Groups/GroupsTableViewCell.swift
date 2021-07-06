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
    
    func configure(image: UIImage?, name: String?) {
        if let image = image {
            groupImage.image = image
        }
        
        if let name = name {
            groupNameLabel.text = name
        } else {
            groupNameLabel.text = "no name"
        }
    }
    
    
    
}
