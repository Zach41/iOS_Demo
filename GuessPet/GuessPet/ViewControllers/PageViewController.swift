//
//  PageViewController.swift
//  GuessPet
//
//  Created by ZachZhang on 16/9/4.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

class PageViewController : UIPageViewController {
    let petCards = PetCardStore.defaultPets()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        setViewControllers([initialViewController], direction: .Forward, animated: true, completion: nil)
    }
}

extension PageViewController : UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? CardViewController, let pageIndex = viewController.pageIndex where pageIndex > 0 {
            return viewControllerAtIndex(pageIndex  - 1)
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? CardViewController, let pageIndex = viewController.pageIndex where pageIndex < petCards.count-1 {
            return viewControllerAtIndex(pageIndex + 1)
        }
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return petCards.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension PageViewController : ViewControllerProvider {
    var initialViewController : UIViewController {
        return viewControllerAtIndex(0)!
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        if let cardViewController =
            UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CardViewController") as? CardViewController {
            cardViewController.pageIndex = index;
            cardViewController.petCard   = petCards[index]
            
            return cardViewController
        }
        
        return nil
    }
}
