//
//  SwipeInteractionController.swift
//  GuessPet
//
//  Created by ZachZhang on 16/9/4.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {
    var interactionInProgress : Bool = false
    private var shouldCompleteTransition : Bool = false
    private weak var viewController : UIViewController!
    
    func wireToViewController(viewController : UIViewController!) {
        self.viewController = viewController
        prepareGestureRecognizerInView(viewController.view)
    }
    
    
    func handleGesture(gestureRecognizer : UIScreenEdgePanGestureRecognizer) {
        let translation = gestureRecognizer.translationInView(gestureRecognizer.view!.superview)
        var progress = translation.x / 200.0
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch gestureRecognizer.state {
        case .Began:
            interactionInProgress = true
            viewController.dismissViewControllerAnimated(true, completion: nil)
        case .Changed:
            shouldCompleteTransition = progress > 0.5
            updateInteractiveTransition(progress)
        case .Cancelled:
            shouldCompleteTransition = false
            interactionInProgress = false
            cancelInteractiveTransition()
        case .Ended:
            interactionInProgress = false
            
            if shouldCompleteTransition {
                finishInteractiveTransition()
            } else {
                cancelInteractiveTransition()
            }
            
        default:
            print("Unsupported")
        }
        
    }
    // MARK: private 
    private func prepareGestureRecognizerInView(view : UIView) {
        let edgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture))
        edgeRecognizer.edges = UIRectEdge.Left
        view.addGestureRecognizer(edgeRecognizer)
    }
}
