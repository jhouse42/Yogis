//
//  PostViewController.swift
//  Yogis
//
//  Created by Jeanie House on 3/28/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var studentInstructor: UISegmentedControl!
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var bio: UITextView!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    
    
    @IBAction func saveProfile(sender: AnyObject) {
    
   savingProfile()
    
    var fieldValues: [String] = [name.text,email.text,bio.text,phone.text]
    
    if find(fieldValues, "") != nil {
    
    var alertViewController = UIAlertController (title:"Try again.", message: "All fields need to be filled in.", preferredStyle: UIAlertControllerStyle.Alert)
    
    var defaultAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
    
    alertViewController.addAction(defaultAction)
    
    presentViewController(alertViewController, animated: true, completion: nil)
    
    } else if (name.text != name.text) {
    
    var alertViewController = UIAlertController (title:"Try again.", message: "Please enter your name.", preferredStyle: UIAlertControllerStyle.Alert)
    
    var defaultAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
    
    alertViewController.addAction(defaultAction)
    
    presentViewController(alertViewController, animated: true, completion: nil)
    
    } else {
    
    println("all fields are good and login")
    
    var userQuery = PFUser.query()
    
    userQuery.whereKey("email", equalTo: email.text)
    
    userQuery.findObjectsInBackgroundWithBlock{(objects, error) -> Void in
    
    if objects.count > 0 {
    
    println(objects)
    
    } else {
    
    println("signUp called")
    self.signUp()
    
    
    }
    

    }
    }
        
        
        
        
        var tbc = storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as? UITabBarController
        
        UIApplication.sharedApplication().keyWindow?.rootViewController = tbc
        


     
    }

func signUp() {
    
    println("signUp")
    
    var user = PFUser()
    
    //user.name = name.text
    user.email = email.text
    //user.bios = bio.text
    //user.phones = phone.text
    user["Name"] = name.text
    user["Email"] = email.text
    user["Bio"] = bio.text
    user["Phone"] = phone.text
   
    
    user.signUpInBackgroundWithBlock {
        (succeeded: Bool!, error: NSError!) -> Void in
        
        if error == nil {
            
            var user = PFUser.currentUser()
            
            
//            var geoCoder = CLGeocoder()
//            
//            geoCoder.geocodeAddressString(self.zipCodeField.text, completionHandler: { (placemarks, error) -> Void in
//                
//                if let placemark = placemarks.first as? CLPlacemark {
//                    
//                    user["location"] = PFGeoPoint(location: placemark.location)
//                    
//                    user.saveInBackgroundWithBlock(nil)
//                    
//                }
//                
//                
//            })
            
            
            println("saved success")
            
            
            self.name.text = ""
            self.bio.text = ""
            self.email.text = ""
            self.phone.text = ""
          
            
        } else {
            
            let errorString = error.userInfo?["error"] as NSString
            println(errorString)
            // Show the errorString somewhere and let the user try again.
        }
    }
}


    func savingProfile() {
        
        var createProfile = PFObject(className:"Profile")
        
        createProfile["Phone"] = phone.text
        createProfile["Name"] = name.text
        createProfile["Bio"] = bio.text
        createProfile["Email"] = email.text
      //  createProfile["senderId"] = PFUser.currentUser().objectId
//        createEvent["receiverId"] = user.objectId
//        createEvent["participants"] = [PFUser.currentUser().objectId,user.objectId]
//        
        createProfile.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                
                //Saved
            } else {
                
                
            }
        }
    }




    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()


    func displayAlert(title:String, error:String) {
        
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    var photoSelected:Bool = false
    
    @IBOutlet var imageToPost: UIImageView!
    
    
    
    
    
    @IBAction func chooseImage(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
        
        
    }
    
    
    //@IBOutlet var shareText: UITextField!
    
    
    @IBAction func postImage(sender: AnyObject) {
        
        var error = ""
        
        if (photoSelected == false) {
            
            error = "Please select a profile image"
        }
        
//        } else if (shareText.text == "") {
//            
//            error = "Please enter a message"
//            
//        }
        
        if (error != "") {
            
            displayAlert("Cannot Post Image", error: error)
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var post = PFObject(className: "Post")
            //post["Title"] = shareText.text
            post["Name"] = PFUser.currentUser().username
            
            post.saveInBackgroundWithBlock{(success: Bool!, error: NSError!) -> Void in
                
                
                if success == false {
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    self.displayAlert("Could Not Post Image", error: "Please try again later")
                    
                } else {
                    
                    let imageData = UIImagePNGRepresentation(self.imageToPost.image)
                    
                    let imageFile = PFFile(name: "image.png", data: imageData)
                    
                    post["imageFile"] = imageFile
                    
                    post.saveInBackgroundWithBlock{(success: Bool!, error: NSError!) -> Void in
                        
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        if success == false {
                            
                            self.displayAlert("Could Not Post Image", error: "Please try again later")
                            
                        } else {
                            
                            self.displayAlert("Image Posted!", error: "Your image has been posted successfully")
                            
                            // Update - change 0 to false
                            
                            self.photoSelected = false
                            
                            self.imageToPost.image = UIImage(named: "yoga1")
                            
                            //self.shareText.text = ""
                            
                            println("posted successfully")
                            
                        }
                        
                    }
                    
                }
                
                
            }
            
            
            
        }
        
        
    }
    
    // Update - removed ! after UIImagePickerController
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("Image selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        
        imageToPost.image = image
        
        photoSelected = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Update - change 0 to false
        
        
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
        

        
        self.imageToPost.layer.cornerRadius = self.imageToPost.frame.size.width / 2;
        self.imageToPost.clipsToBounds = true;
        
        photoSelected = false
        
        imageToPost.image = UIImage(named: "yoga1")
        
      //  shareText.text = ""
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
