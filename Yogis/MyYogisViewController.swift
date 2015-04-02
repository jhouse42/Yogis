//
//  MyYogisViewController.swift
//  Yogis
//
//  Created by Jeanie House on 3/24/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit

class MyYogisViewController: UIViewController {
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
   
    
   //  private var imageSet = ["tri"]
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
//        
//        
//        let selectedImageIndex = Int(arc4random_uniform(1))
//        
//        
//        // Apply blurring effect
//         backgroundImageView.image = UIImage(named: imageSet[selectedImageIndex])
//        //backgroundImageView.image = UIImage(named: "tri")
//        let blurEffect = UIBlurEffect(style: .Light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        backgroundImageView.addSubview(blurEffectView)
//        
//        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}

