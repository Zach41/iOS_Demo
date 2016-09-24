//
//  IndicatorAnimationPacman.swift
//  IndicatorViewDemo
//
//  Created by ZachZhang on 2016/9/24.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

class IndicatorAnimationPacman: NSObject {
    fileprivate func pacmanIn(layer: CALayer, size: CGSize, color: UIColor) {
        let pacmanSize = 2 * size.width / 3
        let pacmanDuraiton = 0.5
        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let strokeStartAnimation = CAKeyframeAnimation(keyPath: "strokeStart")
        strokeStartAnimation.keyTimes = [0, 0.5, 1]
        strokeStartAnimation.timingFunctions = [timingFunction, timingFunction]
        strokeStartAnimation.values = [0.125, 0, 0.125]
        strokeStartAnimation.duration = pacmanDuraiton
        
        let strokeEndAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.keyTimes = [0, 0.5, 1]
        strokeEndAnimation.timingFunctions = [timingFunction, timingFunction]
        strokeEndAnimation.values = [0.875, 1, 0.875]
        strokeEndAnimation.duration = pacmanDuraiton
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        animationGroup.duration = pacmanDuraiton
        animationGroup.repeatCount = HUGE
        animationGroup.isRemovedOnCompletion = false
        
        let pacman = IndicatorViewShape.pacman.layerWith(size: CGSize(width: pacmanSize, height: pacmanSize), color: color)
        let frame = CGRect(x: (layer.bounds.size.width - pacmanSize) / 2 ,
                           y: (layer.bounds.size.height - pacmanSize) / 2,
                           width: pacmanSize,
                           height: pacmanSize)
        pacman.frame = frame
        pacman.add(animationGroup, forKey: "animation")
        layer.addSublayer(pacman)
    }
    
    fileprivate func circleIn(layer: CALayer, size: CGSize, color: UIColor) {
        let circleSize = size.width / 5
        let circleDuration = 1.0
        
        let translateAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        translateAnimation.fromValue = 0
        translateAnimation.toValue = -size.width / 2.0
        translateAnimation.duration = circleDuration
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.7
        opacityAnimation.duration = circleDuration
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [translateAnimation, opacityAnimation]
        animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animationGroup.duration = circleDuration
        animationGroup.repeatCount = HUGE
        animationGroup.isRemovedOnCompletion = false
        
        let circle = IndicatorViewShape.circle.layerWith(size: CGSize(width: circleSize, height: circleSize), color: color)
        let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2 + size.width - circleSize,
                           y: (layer.bounds.size.height - circleSize) / 2 ,
                           width: circleSize,
                           height: circleSize)
        circle.frame = frame
        circle.add(animationGroup, forKey: "animation")
        layer.addSublayer(circle)
    }
    
}

extension IndicatorAnimationPacman : IndicatorAnimationDelegate {
    func setupAnimationIn(layer: CALayer, size: CGSize, color: UIColor) {
        circleIn(layer: layer, size: size, color: color)
        pacmanIn(layer: layer, size: size, color: color)
    }
}
