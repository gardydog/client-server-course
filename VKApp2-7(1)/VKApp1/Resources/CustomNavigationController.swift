//
//  CustomNavigationController.swift
//  VKApp1
//
//  Created by Mac on 13.06.2021.
//

import UIKit

//Класс для отслеживания выполнения анимации
class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var isStarted = false
    var shouldFinished = false
    
}

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        let edgePanGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(hadlePan(_ :)))
        edgePanGR.edges = .left //Свайп от левого края направо
        view.addGestureRecognizer(edgePanGR)
    }
    
    @objc
    func hadlePan(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveTransition.isStarted = true
            popViewController(animated: true)
       
        case .changed:
            //Отслеживаем ширину, чтобы отслеживать наше действие
            guard let width = recognizer.view?.bounds.width else {
                interactiveTransition.isStarted = false
                interactiveTransition.cancel()
                return
            }
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / width
            let progress = max(0, min(relativeTranslation, 1))
            interactiveTransition.update(progress)
            interactiveTransition.shouldFinished = progress > 0.30
        
        case .ended:
            interactiveTransition.isStarted = false
            interactiveTransition.shouldFinished ? interactiveTransition.finish() : interactiveTransition.cancel()
        
        case .cancelled:
            interactiveTransition.isStarted = false
            interactiveTransition.cancel()
            
        default: break
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            return AnimatorClose()
        case .push:
            return AnimatorOpen()
        default:
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        interactiveTransition.isStarted ? interactiveTransition : nil
    }
    
}
