//
//  DropDownNotification.swift
//  DropDownNotification
//
//  Created by ZachZhang on 16/7/14.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import Foundation
import UIKit

protocol DropDownNotificationDelegate : class {
    func dropDownNotificationTopButtonTaped(sender: UIButton);
    func dropDownNotificationBottomButtonTapped(sender: UIButton);
    func dropDownNotificationTapped(sender: UIView);
}

class DropDownNotification : NSObject {
//    常量
    private  let  kPaddingWidth: CGFloat       = 10.0
    private  let  kImageSize: CGFloat          = 40.0
    private  let  kTitleFontSize: CGFloat      = 19.0
    private  let  kSubtitleFontSize: CGFloat    = 14.0
    private  let  kButtonWidth: CGFloat         = 75.0
    private  let  kButtonHeight: CGFloat        = 30.0
    
    private let notificationView : UIView!
    
    var titleText : String?
    var subTitleText : String?
    var image : UIImage?
    
    var topButtonText: String!
    var bottomButtonText: String!
    
    private var isShowing: Bool = false
//    private var dismissOnTap : Bool = true
    
    weak var delegate : DropDownNotificationDelegate?
    
    private let titleLabel : UILabel!
    private let subtitleLabel: UILabel!
    private let imageView: UIImageView!
    private let topButton: UIButton!
    private let bottomButton: UIButton!
    
//    动画
    private var animator : UIDynamicAnimator! = nil
    
    func present() {
        layoutViews()
        
        let offset = notificationView.bounds.size.height
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        
        animator = UIDynamicAnimator(referenceView: UIApplication.sharedApplication().keyWindow!)
        
        let gravity  = UIGravityBehavior(items: [notificationView])
        animator.addBehavior(gravity)
        
        let collision = UICollisionBehavior(items: [notificationView])
        collision.translatesReferenceBoundsIntoBoundary = false
        collision.addBoundaryWithIdentifier("notificationEnd", fromPoint: CGPoint(x: 0, y: offset), toPoint: CGPoint(x: screenWidth, y: offset))
        animator.addBehavior(collision)
        
        let elasticity = UIDynamicItemBehavior(items: [notificationView])
        elasticity.elasticity = 0.3;
        animator.addBehavior(elasticity)
        
        isShowing = true
    }
    
    @objc private func tapDismiss() {
        dismiss()
        
        delegate?.dropDownNotificationTapped(notificationView)
        
    }
    
    private func dismiss() {
        if !isShowing {
            return
        }
        
        let gravityReversed = UIGravityBehavior(items: [notificationView])
        animator.removeAllBehaviors()
        gravityReversed.gravityDirection = CGVector(dx: 0, dy: -1.5)
        animator.addBehavior(gravityReversed)
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.animator.removeAllBehaviors()
            self.notificationView.removeFromSuperview()
            for v in self.notificationView.subviews {
                v.removeFromSuperview()
            }
        }

    }
    
    override init() {
        notificationView = UIView()
        notificationView.backgroundColor = UIColor.clearColor()
        
        titleLabel = UILabel()
        titleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: kTitleFontSize)
        titleLabel.textColor = UIColor.blackColor()
        
        subtitleLabel = UILabel()
        subtitleLabel.font = UIFont(name: "HelveticaNeue", size: kSubtitleFontSize)
        subtitleLabel.textColor = UIColor.blackColor()
        subtitleLabel.numberOfLines = 0
        
        imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        
        topButton = UIButton(type: .Custom)
        topButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: kSubtitleFontSize)
        topButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        topButton.adjustsImageWhenHighlighted = true
        topButton.backgroundColor = UIColor.clearColor()
        
        topButton.layer.cornerRadius = 10.0
        topButton.layer.borderWidth  = 1.0
        topButton.layer.borderColor  = UIColor.grayColor().CGColor
        topButton.layer.masksToBounds = true
        
        bottomButton = UIButton(type: .Custom)
        bottomButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: kSubtitleFontSize)
        bottomButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        bottomButton.adjustsImageWhenHighlighted = true
        bottomButton.backgroundColor = UIColor.clearColor()
        
        bottomButton.layer.cornerRadius = 10.0
        bottomButton.layer.borderWidth  = 1.0
        bottomButton.layer.borderColor  = UIColor.grayColor().CGColor
        bottomButton.layer.masksToBounds = true
    }
    
    private func layoutViews() {
        let screenSize = UIScreen.mainScreen().bounds.size
        
        let textWidth = screenSize.width - kPaddingWidth - kImageSize - kPaddingWidth*2 - kButtonWidth - kPaddingWidth
        subtitleLabel.preferredMaxLayoutWidth = textWidth
        
        let _title = titleText! as NSString
        let _subtitle = subTitleText! as NSString
        
        let titleHeight = _title.boundingRectWithSize(CGSize(width: textWidth, height: 999), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : titleLabel.font], context: nil).size.height
        
        let subtitleHeight = _subtitle.boundingRectWithSize(CGSize(width: textWidth, height: 999), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : subtitleLabel.font], context: nil).size.height
        
        let viewHeight = max(20.0 + kPaddingWidth + titleHeight + subtitleHeight + (kPaddingWidth / 2.0) + kPaddingWidth, 100.0)
        
        notificationView.frame = CGRect(x: 0, y: -viewHeight, width: screenSize.width, height: viewHeight)
        let blurEffect = UIBlurEffect(style: .Light)
        let blurView   = UIVisualEffectView(effect: blurEffect)
        blurView.frame = notificationView.bounds
        notificationView.addSubview(blurView)
        
//        一定要是最前的window
        UIApplication.sharedApplication().keyWindow?.addSubview(notificationView)
        UIApplication.sharedApplication().keyWindow?.bringSubviewToFront(notificationView)
        
        imageView.frame = CGRect(x: kPaddingWidth, y: (viewHeight - kImageSize) / 2.0, width: kImageSize, height: kImageSize)
        notificationView.addSubview(imageView);
        imageView.image = image
        notificationView.addSubview(imageView)
        
        titleLabel.frame = CGRect(x: kPaddingWidth*2 + kImageSize, y: 20 + kPaddingWidth, width: textWidth, height: titleHeight)
        titleLabel.text = titleText
        notificationView.addSubview(titleLabel)
        
        subtitleLabel.frame = CGRect(x: kPaddingWidth*2 + kImageSize, y: 20 + kPaddingWidth + kPaddingWidth / 2 + titleHeight, width: textWidth, height: subtitleHeight)
        subtitleLabel.text = subTitleText
        notificationView.addSubview(subtitleLabel)
        
        topButton.frame = CGRect(x: kPaddingWidth*3 + textWidth + kImageSize, y: 20 + kPaddingWidth / 2.0, width: kButtonWidth, height: kButtonHeight)
        topButton.addTarget(self, action: #selector(buttonClicked), forControlEvents: .TouchUpInside)
        notificationView.addSubview(topButton)
        topButton.setTitle(topButtonText, forState: .Normal)
        
        bottomButton.frame = CGRect(x: topButton.frame.origin.x, y: viewHeight - kPaddingWidth - kButtonHeight, width: kButtonWidth, height: kButtonHeight)
        bottomButton.addTarget(self, action: #selector(buttonClicked), forControlEvents: .TouchUpInside)
        notificationView.addSubview(bottomButton)
        bottomButton.setTitle(bottomButtonText, forState: .Normal)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDismiss))
        notificationView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func buttonClicked(sender: UIButton) {
        dismiss()
        
        if sender == topButton {
            delegate?.dropDownNotificationTopButtonTaped(topButton)
        } else {
            delegate?.dropDownNotificationBottomButtonTapped(bottomButton)
        }
    }
}