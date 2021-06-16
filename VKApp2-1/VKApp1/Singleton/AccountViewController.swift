//
//  AccountViewController.swift
//  VKApp1
//
//  Created by Mac on 16.06.2021.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var accessToken: UITextField!
    @IBOutlet weak var userID: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accessToken.text = Session.shared.token
        userID.text = String(Session.shared.userId)
    }
    

   

}
