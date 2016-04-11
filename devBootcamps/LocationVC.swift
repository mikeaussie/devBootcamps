//
//  SecondViewController.swift
//  devBootcamps
//
//  Created by Mike Piatin on 11/04/2016.
//  Copyright © 2016 Aurora Software. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    let regionalRadius: CLLocationDistance = 1000
    
    let addresses = ["25 Ganley St South Gladstone QLD 4680","975 HANSON Rd Yarwun QLD 4694","65 Dawson Rd West Gladstone QLD 4680"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        for add in addresses {
            getPlacemarkFromAddress(add)
        }
        
    }

    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
        
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            map.showsUserLocation = true
            
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionalRadius * 2, regionalRadius * 2)
        map.setRegion(coordinateRegion, animated: true)
        
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            centerMapOnLocation(loc)
            
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        //customisation of pins. the function must be called before the annotation
        if annotation.isKindOfClass(BootcampAnnotation) {
            let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annoView.pinTintColor = UIColor.blackColor()
            annoView.animatesDrop = true
            return annoView
            
        } else if annotation.isKindOfClass(MKUserLocation) { //this part of the code is optional, a kind of redundancy
            return nil
        }
        
        return nil
    }
    
    func createAnnotationForLocation(location: CLLocation) {
        let bootcamp = BootcampAnnotation(coordinate: location.coordinate)
        map.addAnnotation(bootcamp)
    }
    
    
    func getPlacemarkFromAddress(address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in

            if let marks = placemarks where marks.count > 0 {
                if let loc = marks[0].location {
                    
                    self.createAnnotationForLocation(loc)
                    
                }
            }
        }
    }
    


}











