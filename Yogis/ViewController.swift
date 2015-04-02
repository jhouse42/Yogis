//
//  ViewController.swift
//  Yogis
//
//  Created by Jeanie House on 3/24/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

var onceToken:dispatch_once_t = 0


var venueLocation: String!


class MyPointAnnotation: MKPointAnnotation {
    
    var index: Int = 0
   
    
}

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var user: PFUser!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func cancelButton(sender: AnyObject) {
        
    navigationController?.popViewControllerAnimated(true)
    }
    
    
    var lManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.delegate = self
        
        mapView.frame = view.frame
        mapView.mapType = .Standard
        
        view.addSubview(mapView)
        
        lManager.requestWhenInUseAuthorization()
        
        
        
        lManager.delegate = self
        
        lManager.desiredAccuracy = kCLLocationAccuracyBest
        
        lManager.distanceFilter = kCLDistanceFilterNone
        
        lManager.startUpdatingLocation()
    
     
        
    }
    
    
 override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//    var nyaLocation = CLLocationCoordinate2DMake(34.059766, -83.997431) 
//        // Drop a pin
//        
//        var dropPin = MKPointAnnotation()
//        dropPin.coordinate = nyaLocation
//        dropPin.title = "Private Lessons"
//        dropPin.subtitle = "nyayoga@gmail.com"
//        
//        mapView.addAnnotation(dropPin)
//        
    
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    
    
    
    // MAKE ANNOTATIONS FOR FEED ITEMS
    
    func createAnnotationsWithStudios(courts: [PFObject]) {
        
        for (i,courts) in enumerate(courts) {
            
            let venue = courts["venue"] as [String:AnyObject]
            
            let locationName = venue["name"] as String
            
            
            
            let locationInfo = venue["location"] as [String:AnyObject]
            
            let lat = locationInfo["lat"] as CLLocationDegrees
            let lng = locationInfo["lng"] as CLLocationDegrees
            
            let coordinate = CLLocationCoordinate2DMake(lat,lng)
            
            let annotation = MyPointAnnotation()
            
            annotation.index = i
            
            annotation.setCoordinate(coordinate)
            
            mapView.addAnnotation(annotation)
            
            
            var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lng)
            var information = MKPointAnnotation()
            information.coordinate = location
            information.title = courts["name"] as String
            information.subtitle = "subtitle"
            
            
            
            mapView.addAnnotation(information)
            
            
        }
        
        
    }
    
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        
        self.refreshMap()
        
    }
    
    
    func refreshMap() {
        
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        let venues = Foursquare.requestVenuesWithLocation(CLLocation(latitude: mapView.region.center.latitude, longitude: mapView.region.center.longitude))
        
        for venue in venues {
            
            
            let venueName = venue["name"] as? String
            
            let locationInfo = venue["location"] as [String:AnyObject]
            
            let lat = locationInfo["lat"] as CLLocationDegrees
            let lng = locationInfo["lng"] as CLLocationDegrees
            
            let coordinate = CLLocationCoordinate2DMake(lat,lng)
            
            let annotation = MKPointAnnotation()
            
            annotation.setCoordinate(coordinate)
            
            
            if let venueName = venueName { annotation.title = venueName }
            
            self.mapView.addAnnotation(annotation)
            
            
        }
        
        
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        
        
        
        var annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnn")
        
        var rightArrowButton = ArrowButton(frame: CGRectMake(0, 0, 30, 30))
        
        
//        let label = UILabel(frame: CGRectMake(0, 0, 10, 5))
//        label.text = "Save"
//        
//        label.textColor = UIColor.blackColor()
//        label.addSubview(annotationView)
//        
//        let locButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
//        locButton.frame = CGRectMake(0, 0, 40, 40)
//        locButton.backgroundColor = UIColor.cyanColor()
//        locButton.layer.cornerRadius = 40 / 2
//        locButton.setTitle("List", forState: UIControlState.Normal)
//        locButton.addTarget(self, action: "locationPressed:", forControlEvents: UIControlEvents.TouchUpInside)
//        locButton.addSubview(annotationView)
//        
//        
        
        rightArrowButton.strokeSize = 2
        rightArrowButton.leftInset = 8
        rightArrowButton.rightInset = 8
        rightArrowButton.topInset = 5
        rightArrowButton.bottomInset = 5
        
        
        annotationView.rightCalloutAccessoryView = rightArrowButton
        
        //annotationView.leftCalloutAccessoryView = locButton
        
        annotationView.canShowCallout = true
   
        rightArrowButton.coordinate = annotation.coordinate
     
        rightArrowButton.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
      
        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            annotationView.pinColor = .Purple
        }
        

       
        return annotationView
        
    }
    
    
//    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
//        
//        
//        // TODO: make this so it only sets venueLocation if the left calloutaccessory was tapped
//        
//        
//        if (control == view.leftCalloutAccessoryView) {
//            
//            venueLocation = view.annotation.title}
//        
//        
//        view.annotation.title
//    }
    
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        mapView.showsUserLocation = true
        
        dispatch_once(&onceToken) { () -> Void in
            
            println(locations.last)
            
            if let location = locations.last as? CLLocation {
                
                self.mapView.centerCoordinate = location.coordinate
                
                let span = MKCoordinateSpanMake(0.1, 0.1)
                
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                
                self.mapView.setRegion(region, animated: true)
                
                self.refreshMap()
                
                
            }
            
        }
    }
   
    
    func buttonClicked (sender : ArrowButton!) {
        println("Button Clicked")
        
        let myCurrentMapItem = MKMapItem.mapItemForCurrentLocation()
        
        let destPlacemark = MKPlacemark(coordinate: sender.coordinate!, addressDictionary: nil)
        let destMapItem = MKMapItem(placemark: destPlacemark)
        
        let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
        
        MKMapItem.openMapsWithItems([myCurrentMapItem,destMapItem], launchOptions: options)
        
        
    }
    
//    func locationPressed (sender : UIButton) {
//        println("location Pressed")
//        
//        
//        
//        var locVC = storyboard?.instantiateViewControllerWithIdentifier("VTVC") as VenuesTableViewController
//        
//        locVC.user = user
//        
//        navigationController?.pushViewController(locVC, animated: true)
//        
//        
//        
//        
//        
//        
//    }
//    
//    
    
}//end







