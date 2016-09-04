//
//  FlipDismissAnimator.swift
//  GuessPet
//
//  Created by ZachZhang on 16/9/4.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

class FlipDismissAnimatorController : NSObject, UIViewControllerAnimatedTransitioning {
    var destinationFrame = CGRect.zero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.6
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let containerView = transitionContext.containerView(),
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
                return
        }
        
//        let initialFrame = fromVC.view.frame
        let finalFrame   = destinationFrame
        
        let snapshot = fromVC.view.snapshotViewAfterScreenUpdates(true)
        snapshot.layer.cornerRadius = 25
        snapshot.layer.masksToBounds = true
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        fromVC.view.hidden = true
        
        AnimationHelper.perspectiveTransformForContainerView(containerView)
        toVC.view.layer.transform = AnimationHelper.yRotation(-M_PI_2)
        
        let duration = transitionDuration(transitionContext)
        
        UIView.animateKeyframesWithDuration(duration,
                                            delay: 0,
                                            options: .CalculationModeCubic,
                                            animations: {
                                                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1.0/3, animations: {
                                                    snapshot.frame = finalFrame
                                                })
                                                
                                                UIView.addKeyframeWithRelativeStartTime(1.0/3, relativeDuration: 1.0/3, animations: {
                                                    snapshot.layer.transform = AnimationHelper.yRotation(M_PI_2)
                                                })
                                                
                                                UIView.addKeyframeWithRelativeStartTime(2.0/3, relativeDuration: 1.0/3, animations: {
                                                    toVC.view.layer.transform = AnimationHelper.yRotation(0.0)
                                                })
            }, completion: { _ in
                fromVC.view.hidden = false
                snapshot.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
}
