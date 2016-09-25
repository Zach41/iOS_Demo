//
//  IndicatorViewable.swift
//  IndicatorViewDemo
//
//  Created by ZachZhang on 2016/9/24.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

public protocol IndicatorViewable {}

public extension IndicatorViewable where Self: UIViewController {
    public func startAnimating(with size: CGSize? = nil,
                               message: String? = nil,
                               type: IndicatorType? = nil,
                               color: UIColor? = nil,
                               padding: CGFloat? = nil,
                               delay: CFTimeInterval? = nil) {
        let activityData = ActivityData(size: size,
                                        message: message,
                                        type: type,
                                        color: color,
                                        padding: padding,
                                        delay: delay)
        IndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    public func stopAnimating() {
        IndicatorPresenter.sharedInstance.stopAnimating()
    }
}
