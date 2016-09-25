//
//  IndicatorPresenter.swift
//  IndicatorViewDemo
//
//  Created by ZachZhang on 2016/9/24.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

public class ActivityData {
    let size : CGSize
    let message : String?
    let type : IndicatorType
    let color : UIColor
    let padding : CGFloat
    let delay : CFTimeInterval
    
    public init(size: CGSize? = nil,
                message: String? = nil,
                type: IndicatorType? = nil,
                color: UIColor? = nil,
                padding: CGFloat? = nil,
                delay: CFTimeInterval? = nil) {
        self.size = size ?? IndicatorView.DEFAULT_SIZE
        self.message = message
        self.type = type ?? IndicatorView.DEFAULT_TYPE
        self.color = color ?? IndicatorView.DEFAULT_COLOR
        self.padding = padding ?? IndicatorView.DEFAULT_PADDING
        self.delay = delay ?? IndicatorView.DEFAULT_DELAY
    }
}

class IndicatorPresenter {
    private let restorationIdentifier = "ActivityIndicatorContainerID"
    private var showTimer : Timer?
    
    // single instance
    public static let sharedInstance = IndicatorPresenter()
    
    private init() {}
    
    public func startAnimating(_ data: ActivityData) {
        guard showTimer == nil else {return}
        showTimer = Timer.scheduledTimer(timeInterval: data.delay, target: self, selector: #selector(showTimerFired(_:)), userInfo: data, repeats: false)
    }
    
    public func stopAnimating() {
        hide()
    }
    
    @objc private func showTimerFired(_ timer: Timer) {
        guard let activityData = timer.userInfo as? ActivityData else {return}
        show(with: activityData)
    }
    
    private func show(with activityData: ActivityData) {
        let containerView = UIView(frame: UIScreen.main.bounds)
        containerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        containerView.restorationIdentifier = restorationIdentifier
        
        let indicatorSize = activityData.size
        let activityIndicatorView = IndicatorView(frame: CGRect(x: 0, y: 0, width: indicatorSize.width, height: indicatorSize.height),
                                                  type: activityData.type,
                                                  color: activityData.color,
                                                  padding: activityData.padding)
        activityIndicatorView.center = containerView.center
        containerView.addSubview(activityIndicatorView)
        
        let width = containerView.frame.size.width / 2.0
        if let message = activityData.message, !message.isEmpty {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 30))
            label.center = CGPoint(x: activityIndicatorView.center.x, y: activityIndicatorView.center.y + indicatorSize.height)
            label.textAlignment = .center
            label.text = message
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = activityData.color
            containerView.addSubview(label)
        }
        activityIndicatorView.startAnimation()
        UIApplication.shared.keyWindow!.addSubview(containerView)
    }
    
    private func hide() {
        for item in UIApplication.shared.keyWindow!.subviews where item.restorationIdentifier == restorationIdentifier {
            item.removeFromSuperview()
        }
        showTimer?.invalidate()
        showTimer = nil
    }
}
