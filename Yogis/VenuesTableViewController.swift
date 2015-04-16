//
//  VenuesTableViewController.swift
//  Sit Fit
//
//  Created by Jeanie House on 2/5/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Parse




class VenuesTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    //var user: PFUser!
    var onceToken:dispatch_once_t = 0
    
    var lManager = CLLocationManager()

    
    var foundVenues: [AnyObject] = []
    
    var postShown = [Bool](count: 60, repeatedValue: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lManager.requestWhenInUseAuthorization()
        lManager.delegate = self
        lManager.startUpdatingLocation()
        
        self.tableView.rowHeight = 100
        
        tableView.backgroundColor = UIColor(red: 0.16, green: 0.48, blue: 0.86, alpha: 1.0)
        tableView.separatorColor = UIColor.whiteColor()
        
        tableView.tableFooterView = UIView(frame:CGRectZero)
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        dispatch_once(&onceToken) { () -> Void in
            
           
            if let location = locations.last as? CLLocation {
                
                
                self.foundVenues = Foursquare.requestVenuesWithLocation(location)
            
                self.tableView.reloadData()
        
            }
            
        }
        
        lManager.stopUpdatingLocation()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundVenues.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("venueCell", forIndexPath: indexPath) as! UITableViewCell

        let venue = foundVenues[indexPath.row] as! [String:AnyObject]
        
        
        cell.textLabel?.text = venue["name"] as? String

         cell.textLabel?.font = UIFont (name: "HelveticaNeue-Thin", size: 20)
       
         cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
       
        lManager.startUpdatingLocation()
        
        return cell
    }

    
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
         let venue = foundVenues[indexPath.row] as! [String:AnyObject]

         var mVC = storyboard?.instantiateViewControllerWithIdentifier("mVC") as! ViewController
        
       // mVC.user = user()
        
        navigationController?.pushViewController(mVC, animated: true)
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if postShown[indexPath.row] {
            return;
        }
        
        postShown[indexPath.row] = true

        let rotationAngleInRadians = 90.0 * CGFloat(M_PI/180.0);
    
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
        cell.layer.transform = rotationTransform;
      
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
