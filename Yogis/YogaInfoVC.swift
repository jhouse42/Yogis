//
//  YogaInfoVC.swift
//  Yogis
//
//  Created by Jeanie House on 3/24/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit

class YogaInfoVC: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.image.layer.cornerRadius = self.image.frame.size.width / 2;
        self.image.clipsToBounds = true;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
