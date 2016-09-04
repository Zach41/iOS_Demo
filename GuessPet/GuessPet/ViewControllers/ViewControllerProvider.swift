//
//  ViewControllerProvider.swift
//  GuessPet
//
//  Created by ZachZhang on 16/9/4.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

protocol ViewControllerProvider {
    var initialViewController : UIViewController {get}
    
    func viewControllerAtIndex(index : Int) -> UIViewController?
}
