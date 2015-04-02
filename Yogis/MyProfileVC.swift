//
//  MyProfileVC.swift
//  Yogis
//
//  Created by Jeanie House on 3/29/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit

class MyProfileVC: UIViewController {
    
    @IBOutlet weak var proImage: UIImageView!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var stuInstruct: UITextField!
    
    @IBOutlet weak var bio: UITextView!
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.proImage.layer.cornerRadius = self.proImage.frame.size.width / 2;
        self.proImage.clipsToBounds = true;

        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            var kbSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size
            
            self.buttonBottomConstraint.constant = 20 + kbSize!.height
            
            self.view.layoutIfNeeded()
            
        }
       
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            
            self.buttonBottomConstraint.constant = 20
            
            
            self.view.layoutIfNeeded()
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
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
