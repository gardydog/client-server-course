//
//  Animator.swift
//  VKApp1
//
//  Created by Mac on 09.06.2021.
//

import UIKit

class AnimatorOpen: NSObject, UIViewControllerAnimatedTransitioning {
    let animateTime: TimeInterval = 1
    
    //Данный метод возвращает время анимации
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
           guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
           else { return }
           
           transitionContext.containerView.addSubview(destination.view)
           //transitionContext.containerView.sendSubviewToBack(destination.view)
           
           destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
           destination.view.frame = transitionContext.containerView.frame
           destination.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
           
           source.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
           source.view.frame = transitionContext.containerView.frame
           
           UIView.animate(
               withDuration: animateTime,
               animations: {
                   source.view.transform = CGAffineTransform(rotationAngle: .pi/2)
                   destination.view.transform = .identity
           }) { (isComplete) in
               if isComplete && !transitionContext.transitionWasCancelled {
                   source.view.transform = .identity
               }
               transitionContext.completeTransition( isComplete && !transitionContext.transitionWasCancelled)
           }
       }
    
    
    
    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//       guard
//            let source = transitionContext.viewController(forKey: .from),
//            let destination = transitionContext.viewController(forKey: .to)
//        else { return }
//            let containerViewFrame = transitionContext.containerView.frame
//
//        //Контроллер, с которого осуществляется переход
//        let sourceViewTargetFrame = CGAffineTransform(translationX: 0,
//                                                      y: 0)
//
//        //Добавляем слой между двумя контроллерами (его невидно), в котором происходит анимация перехода
//        transitionContext.containerView.addSubview(destination.view)
//
//        //То место, откуда у нас будет появляться новая View
//        destination.view.transform = CGAffineTransform(translationX: -containerViewFrame.width,
//                                                       y: 0).concatenating(CGAffineTransform(rotationAngle: .pi / 180 * -270))
//
//        UIView.animateKeyframes(withDuration: animateTime / 2,
//                                delay: 0,
//                                options: .calculationModePaced,
//                                animations: {
//                                    let translation = sourceViewTargetFrame
//                                    source.view.transform = translation
//                                },
//                                completion: nil)
//
//        UIView.animateKeyframes(withDuration: animateTime / 2,
//                                delay: 0,
//                                options: .calculationModePaced,
//                                animations: {
//                                    destination.view.transform = .identity
//                                },
//                                completion: transitionContext.completeTransition(_:))
        
        
//        UIView.animate(withDuration: animateTime / 2,
//                       animations: {
//                        source.view.frame = sourceViewTargetFrame
//                       }, completion: nil)
//        UIView.animate(withDuration: animateTime / 2, animations: {
//            destination.view.frame = CGRect(x: 0,
//                                            y: 0,
//                                            width: containerViewFrame.width,
//                                            height: containerViewFrame.height)
//        }, completion: transitionContext.completeTransition(_:))
//   }
    
    
}
