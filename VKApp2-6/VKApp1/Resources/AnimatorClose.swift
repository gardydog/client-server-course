//
//  AnimatorClose.swift
//  VKApp1
//
//  Created by Mac on 09.06.2021.
//

import UIKit

class AnimatorClose: NSObject, UIViewControllerAnimatedTransitioning {
    let animateTime: TimeInterval = 1

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            guard  let source = transitionContext.viewController(forKey: .from) else { return }
            guard  let destination = transitionContext.viewController(forKey: .to) else { return }
            
            transitionContext.containerView.addSubview(destination.view)
            
            destination.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
            destination.view.frame = transitionContext.containerView.frame
            destination.view.transform = CGAffineTransform(rotationAngle: .pi/2)
            
            source.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
            source.view.frame = transitionContext.containerView.frame
            
            UIView.animate(
                withDuration: animateTime,
                animations: {
                    source.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
                    destination.view.transform = .identity
            }) { (isComplete) in
                if isComplete && !transitionContext.transitionWasCancelled {
                    source.removeFromParent()
                } else if transitionContext.transitionWasCancelled {
                    destination.view.transform = .identity
                }
                transitionContext.completeTransition( isComplete && !transitionContext.transitionWasCancelled)
            }
        }
    
}
