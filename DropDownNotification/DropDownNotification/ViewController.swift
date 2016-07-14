//
//  ViewController.swift
//  DropDownNotification
//
//  Created by ZachZhang on 16/7/14.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var notiManager : DropDownNotification! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        notiManager = DropDownNotification()
        notiManager.image = UIImage(named: "update")
        notiManager.titleText = "🈶️新的更新"
        notiManager.subTitleText = "更正了之前版本的多个错误，优化了用户体验，提升了关键功能的性能"
        notiManager.topButtonText = "Accept"
        notiManager.bottomButtonText = "Ignore"
        
        notiManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showNotification(sender: AnyObject) {
        notiManager.present()
    }

}

extension ViewController : DropDownNotificationDelegate {
    func dropDownNotificationTapped(sender: UIView) {
        print("Tapped")
    }
    
    func dropDownNotificationTopButtonTaped(sender: UIButton) {
        print("Top Button")
    }
    
    func dropDownNotificationBottomButtonTapped(sender: UIButton) {
        print("Bottom Button")
    }
}