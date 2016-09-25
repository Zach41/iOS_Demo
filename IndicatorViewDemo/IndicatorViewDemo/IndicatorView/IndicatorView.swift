//
//  IndicatorView.swift
//  IndicatorViewDemo
//
//  Created by ZachZhang on 2016/9/24.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

public enum IndicatorType: Int {
    case pacman
    
    func animation() -> IndicatorAnimationDelegate {
        switch self {
        case .pacman:
            return IndicatorAnimationPacman()
        }
    }
}

class IndicatorView: UIView {
    
    public static var DEFAULT_TYPE = IndicatorType.pacman
    
    public static var DEFAULT_COLOR = UIColor.white
    
    public static var DEFAULT_PADDING : CGFloat = 0
    
    public static var DEFAULT_DELAY : CFTimeInterval = 0
    
    public static var DEFAULT_SIZE : CGSize = CGSize(width: 60, height: 60)
    
    
    public var type = IndicatorView.DEFAULT_TYPE
    
    public var color = IndicatorView.DEFAULT_COLOR
    
    public var padding = IndicatorView.DEFAULT_PADDING
    
    public private(set) var animating = false
    
    public init(frame: CGRect, type: IndicatorType? = nil, color: UIColor? = nil, padding: CGFloat? = nil) {
        self.type = type ?? IndicatorView.DEFAULT_TYPE
        self.color = color ?? IndicatorView.DEFAULT_COLOR
        self.padding = padding ?? IndicatorView.DEFAULT_PADDING
        super.init(frame: frame)
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startAnimation() {
        self.isHidden = false
        self.animating = true
        setupAnimation()
    }
    
    public func stopAnimation() {
        self.isHidden = true
        self.animating = false
        self.layer.sublayers?.removeAll()
    }
    
    private func setupAnimation() {
        let animation = self.type.animation()
        let animationRect = UIEdgeInsetsInsetRect(self.frame, UIEdgeInsetsMake(padding, padding, padding, padding))
        let minEdge = min(animationRect.width, animationRect.height)
        
        self.layer.sublayers = nil
        animation.setupAnimationIn(layer: self.layer, size: CGSize(width: minEdge, height: minEdge), color: self.color)
    }
}
