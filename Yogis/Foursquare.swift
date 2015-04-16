//
//  Foursquare.swift
//  Yogis
//
//  Created by Jeanie House on 3/24/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit
import CoreLocation


let API_URL = "https://api.foursquare.com/v2/venues/search?"

//let VENUE_ID = "https://api.foursquare.com/v2/venues/VENUE_ID/hours"

let CLIENT_ID = "2X3ZDBL2JCCX54RIXIDGX4M4ZYU3XXYTKUMZ3ZO3X5HNDJP3"

let CLIENT_SECRET = "DSH530ZUBXJ5MY2ZYMRFVR4X4SY1TL4CPNORFANZ2VMLK0AW"


let YOGA_QUERY = "Yoga"


class Foursquare: NSObject {
    class func requestVenuesWithLocation(location: CLLocation) -> [AnyObject] {
        
        //categories, tenniscourts
        let requestString = "\(API_URL)client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20130815&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)&query=\(YOGA_QUERY)"
        
        println(requestString)
        
        
        if  let url = NSURL(string: requestString) {
            
            let request = NSURLRequest(URL: url)
            
            
            
            if let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil) {
                
                if let returnInfo = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? [String:AnyObject] {
                    
                    if let responseInfo = returnInfo["response"] as? [String:AnyObject]{
                        println(responseInfo)
                        
                        
                        return responseInfo["venues"] as! [AnyObject]
                    }
                    if let responseInfo = returnInfo["timeframes"] as? [String:AnyObject]{
                        println(responseInfo)
                        
                        
                        return responseInfo["venues"] as! [AnyObject]
                    }
                    
                }
      
            }
      
        }
  
        
        return []
        
    }
    

}





