//
//  AnimationHelper.swift
//  GuessPet
//
//  Created by ZachZhang on 16/9/4.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

struct AnimationHelper {
    static func yRotation(angle: Double) -> CATransform3D {
        return CATransform3DMakeRotation(CGFloat(angle), 0, 1.0, 0.0)
    }
    
    static func perspectiveTransformForContainerView(containerView : UIView) {
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500.0
        containerView.layer.sublayerTransform = transform
    }
}
