//
//  IndicatorAnimationDelegate.swift
//  IndicatorViewDemo
//
//  Created by ZachZhang on 2016/9/24.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

protocol IndicatorAnimationDelegate {
    func setupAnimationIn(layer: CALayer, size: CGSize, color: UIColor)
}
