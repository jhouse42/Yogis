//
//  ShowYogisTVC.swift
//  Yogis
//
//  Created by Jeanie House on 3/26/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit

class ShowYogisTVC: UITableViewController {
    
    var postShown = [Bool](count: 40, repeatedValue: false)
    
    var yogis: [PFUser] = []
    let postTitles = []
    
    
    var chosenName:[String] = []
    var chosenPhone:[String] = []
    var chosenEmail:[String] = []
    var chosenBio:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tableView.rowHeight = 250
        
        
        tableView.backgroundColor = UIColor(red: 0.16, green: 0.48, blue: 0.86, alpha: 1.0)
        tableView.separatorColor = UIColor.blueColor()

        tableView.tableFooterView = UIView(frame:CGRectZero)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
      
    }

    func refreshYogis() {
        
        var yogiQuery = PFUser.query()
        
//        if let selfGeo = PFUser.currentUser()["location"] as? PFGeoPoint {
//            
//            // add buttons for narrowing down to 10 and 5 mile radius
//            
//            playerQuery.whereKey("location", nearGeoPoint: selfGeo, withinMiles: mileDistance)
//            
//        }
        
        
        
        if chosenName.count > 0 { yogiQuery.whereKey("Name", containedIn: chosenName) }
        
        if chosenPhone.count > 0 { yogiQuery.whereKey("Phone", containedIn: chosenPhone)}
    
        if chosenBio.count > 0 { yogiQuery.whereKey("Bio", containedIn: chosenBio)}
        
        if chosenEmail.count > 0 { yogiQuery.whereKey("Email", containedIn: chosenEmail)}
        
       // if bio != "" { playerQuery.whereKey("gender", equalTo: gender) }
     
        yogiQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            // update players = objects & reloadData
            self.yogis = objects as [PFUser]
            
            println(self.yogis)
            
            self.tableView.reloadData()
            
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return yogis.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("yogiCell", forIndexPath: indexPath) as YogiCell
        
        let yogi = yogis[indexPath.row]
        println(yogis)
        
        cell.nameLabel.text = yogi["Name"] as? String
        cell.phoneLabel.text = yogi["Phone"] as? String
        cell.emailLabel.text = yogi["Email"] as? String
        cell.bioLabel.text = yogi["Bio"] as? String

        
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
   
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // Determine if the post is displayed. If yes, we just return and no animation will be created
        if postShown[indexPath.row] {
            return;
        }
        
        // Indicate the post has been displayed, so the animation won't be displayed again
        postShown[indexPath.row] = true
       
        
        // Define the initial state (Before the animation)
        let rotationAngleInRadians = 90.0 * CGFloat(M_PI/180.0);
        //        let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians, 0, 0, 1);
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
        cell.layer.transform = rotationTransform;
        
        // Define the final state (After the animation)
        UIView.animateWithDuration(1.0, animations: { cell.layer.transform = CATransform3DIdentity })
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
