//
//  IndicatorViewShape.swift
//  IndicatorViewDemo
//
//  Created by ZachZhang on 2016/9/24.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

enum IndicatorViewShape {
    case circle
    case pacman
    
    func layerWith(size: CGSize, color: UIColor) -> CALayer {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        
        switch self {
        case .circle:
            path.addArc(withCenter: CGPoint(x: size.width / 2.0, y: size.height / 2.0),
                        radius: size.width / 2.0,
                        startAngle: 0,
                        endAngle: CGFloat.pi * 2.0,
                        clockwise: false)
            layer.fillColor = color.cgColor
        case .pacman:
            path.addArc(withCenter: CGPoint(x: size.width / 2.0, y: size.height / 2.0),
                        radius: size.width / 4.0,
                        startAngle: 0,
                        endAngle: CGFloat.pi * 2.0,
                        clockwise: true)
            layer.fillColor = nil
            layer.lineWidth = size.width / 2.0
            layer.strokeColor = color.cgColor
        }
        layer.path = path.cgPath
        layer.backgroundColor = nil
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        return layer
    }
}
