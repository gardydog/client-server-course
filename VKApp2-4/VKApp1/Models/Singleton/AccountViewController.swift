//
//  AccountViewController.swift
//  VKApp1
//
//  Created by Mac on 16.06.2021.
//

import UIKit
import Alamofire

class AccountViewController: UIViewController {
    
    @IBOutlet weak var accessToken: UITextField!
    @IBOutlet weak var userID: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accessToken.text = TestSession.shared.token
        userID.text = String(TestSession.shared.userId)
    }
    

   

}
