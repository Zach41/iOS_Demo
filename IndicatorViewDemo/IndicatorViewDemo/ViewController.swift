//
//  ViewController.swift
//  IndicatorViewDemo
//
//  Created by ZachZhang on 2016/9/24.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, IndicatorViewable {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("view loaded")
        self.view.backgroundColor = UIColor.blue
//        // Do any additional setup after loading the view, typically from a nib.
//        let indicatorView = IndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
//        indicatorView.center = self.view.center
//        self.view.addSubview(indicatorView)
//        indicatorView.startAnimation()
        startAnimating(with: CGSize(width: 60, height: 60), message: "Loading...")
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) {
            timer in
            self.stopAnimating()
            print("Task Done")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

