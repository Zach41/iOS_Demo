//
//  CardViewController.swift
//  GuessPet
//
//  Created by ZachZhang on 16/9/4.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

private let revealSequeId = "revealSegue"

class CardViewController : UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let flipPresentAnimator = FlipPresentAnimationController()
    let flipDismissAnimator = FlipDismissAnimatorController()
    let swipeAnimator      = SwipeInteractionController()
    
    
    var pageIndex : Int?
    var petCard : PetCard?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.layer.cornerRadius = 25
        cardView.layer.masksToBounds = true
        titleLabel.text = petCard?.description
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        cardView.addGestureRecognizer(tapRecognizer)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == revealSequeId, let destinationController = segue.destinationViewController as? RevealViewController {
            destinationController.petCard = petCard;
            destinationController.transitioningDelegate = self
            swipeAnimator.wireToViewController(destinationController)
        }
    }
    
    func handleTap() {
        performSegueWithIdentifier(revealSequeId, sender: nil)
    }
}

extension CardViewController : UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        flipPresentAnimator.originFrame = cardView.frame
        return flipPresentAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        flipDismissAnimator.destinationFrame = cardView.frame
        return flipDismissAnimator
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeAnimator.interactionInProgress ? swipeAnimator : nil
    }
}