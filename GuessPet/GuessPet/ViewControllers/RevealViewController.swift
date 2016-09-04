//
//  RevealViewController.swift
//  GuessPet
//
//  Created by ZachZhang on 16/9/4.
//  Copyright © 2016年 ZachZhang. All rights reserved.
//

import UIKit

class RevealViewController : UIViewController {
    var petCard : PetCard?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = petCard?.name
        imageView.image = petCard?.image
    }
    @IBAction func dismissPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
