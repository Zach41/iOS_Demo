//
//  FlipPresentAnimationController.swift
//  GuessPet
//
//  Created by ZachZhang on 16/9/4.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

class FlipPresentAnimationController : NSObject, UIViewControllerAnimatedTransitioning {
    var originFrame = CGRect.zero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let containerView = transitionContext.containerView(),
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
                return;
        }
        
        let initialFrame = originFrame
        let finalFrame   = transitionContext.finalFrameForViewController(toVC)
        
        let snapshotView = toVC.view.snapshotViewAfterScreenUpdates(true)
        snapshotView.layer.cornerRadius = 25
        snapshotView.layer.masksToBounds = true
        snapshotView.frame = initialFrame
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotView)
        toVC.view.hidden = true
        
        AnimationHelper.perspectiveTransformForContainerView(containerView)
        snapshotView.layer.transform = AnimationHelper.yRotation(M_PI_2)
        
        let duration = transitionDuration(transitionContext)
        
        UIView.animateKeyframesWithDuration(duration,
                                            delay: 0,
                                            options: .CalculationModeCubic,
                                            animations: {
                                                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1.0/3, animations: {
                                                    fromVC.view.layer.transform = AnimationHelper.yRotation(-M_PI_2)
                                                })
                                                
                                                UIView.addKeyframeWithRelativeStartTime(1.0/3, relativeDuration: 1.0/3, animations: {
                                                    snapshotView.layer.transform = AnimationHelper.yRotation(0.0)
                                                })
                                                
                                                UIView.addKeyframeWithRelativeStartTime(2.0/3, relativeDuration: 1.0/3, animations: {
                                                    snapshotView.frame = finalFrame
                                                })
            }, completion: { _ in
                toVC.view.hidden = false
                fromVC.view.layer.transform = AnimationHelper.yRotation(0.0)
                snapshotView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
        
    }
}
