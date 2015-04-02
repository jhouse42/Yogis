//
//  PickedLocVC.swift
//  Yogis
//
//  Created by Jeanie House on 4/1/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit
import MapKit

class PickedLocVC: UIViewController {
    
    var user: PFUser!
    
    @IBOutlet weak var locLabel: UILabel!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if venueLocation == nil {
            locLabel.text = "Choose Location:"
        }else{
            
            locLabel.text = venueLocation
            println(locLabel.text)
        }
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
