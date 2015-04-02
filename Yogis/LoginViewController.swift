//
//  LoginViewController.swift
//  Yogis
//
//  Created by Jeanie House on 3/28/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var bio: UITextView!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var number: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    
    
    
    
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageV: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        checkIfLoggedIn()
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            var kbSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size
            
            self.buttonBottomConstraint.constant = 20 + kbSize!.height
            
            // self.view.frame.origin.y = -kbSize.height
            
            self.view.layoutIfNeeded()
            
        }
        
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            
            self.buttonBottomConstraint.constant = 20
            
            
            self.view.layoutIfNeeded()
            
        }
        
        
    }
    
    
    
    func login() {
        
        
        PFUser.logInWithUsernameInBackground(usernameField.text, password:passwordField.text) {
            
            
            (user: PFUser!, error: NSError!) -> Void in
            
            if user != nil {
                println("logged in a \(user)")
                
                self.isLoggedIn = true
                self.checkIfLoggedIn()
                
                
            } else {
                // The login failed. Check error to see why.
                
            }
        }
    }
    
    
    func signUp() {
        
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user["Name"] = name.text
        user["Email"] = email.text
        user["Bio"] = bio.text
        user["Phone"] = number.text
        
        
        
        // other fields can be set just like with PFObject
        
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                println(user)
                
                
                self.isLoggedIn = true
                self.checkIfLoggedIn()
                
                self.usernameField.text = ""
                self.passwordField.text = ""
                
                
                // Hooray! Let them use the app now.
            } else {
                
                let errorString = error.userInfo?["error"] as NSString
                // Show the errorString somewhere and let the user try again.
            }
            
        }
    }
    
    
    
    @IBAction func loginRegister(sender: AnyObject) {
        
        //       isLoggedIn = true
        //
        //       checkIfLoggedIn()
        
        
        var fieldValues: [String] = [usernameField.text,passwordField.text]
        
        if find(fieldValues, "") != nil {
            var alert = UIAlertController(title: "Sign in failed", message: "All fields must be filled in", preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "Login", style: .Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }else{
            
            println("all fields are good")
            
            var userQuery = PFUser.query()
            
            userQuery.whereKey("username", equalTo: usernameField.text)
            
            userQuery.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                if objects.count > 0 {
                    self.login()
                    
                }else{
                    
                    self.signUp()
                    
                    
                }
                
                
                
            })
            
            
            
        }
        
        
        var tbc = storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as? UITabBarController
        
        UIApplication.sharedApplication().keyWindow?.rootViewController = tbc
        
    }
    
    var isLoggedIn: Bool {
        
        get {
            
            return NSUserDefaults.standardUserDefaults().boolForKey("isLoggedIn")
            
        }
        
        set {
            
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "isLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
        
    }
    
    func checkIfLoggedIn() {
        
        
        
        if isLoggedIn {
            
            var tbc = storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as? UITabBarController
            
            UIApplication.sharedApplication().keyWindow?.rootViewController = tbc
            
            
            
            
            
        }
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
}



        