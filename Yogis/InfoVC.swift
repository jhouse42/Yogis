//
//  InfoVC.swift
//  Yogis
//
//  Created by Jeanie House on 4/1/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit
import Parse

class InfoVC: UIViewController {
    
      //var user: PFUser!

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var infoText: UILabel!
    
    @IBAction func findButton(sender: AnyObject) {
        
        var fVC = storyboard?.instantiateViewControllerWithIdentifier("VTVC") as! VenuesTableViewController
        
        //fVC.user = user()
        
        navigationController?.pushViewController(fVC, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.16, green: 0.48, blue: 0.86, alpha: 1.0)
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
