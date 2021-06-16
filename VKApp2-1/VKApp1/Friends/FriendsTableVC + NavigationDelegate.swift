//
//  FriendsTableVC + NavigationDelegate.swift
//  VKApp1
//
//  Created by Mac on 09.06.2021.
//

import UIKit

extension FriendsTableViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            return AnimatorOpen()
        }
        
        if operation == .pop {
            return AnimatorClose()
        }
        
        return nil
    }
    
    
}
