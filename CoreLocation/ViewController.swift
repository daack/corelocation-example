//
//  ViewController.swift
//  CoreLocation
//
//  Created by Matteo Maselli on 08/11/14.
//  Copyright (c) 2014 Matteo Maselli. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    var locationManager: CLLocationManager = CLLocationManager()
    var pointAnnotetions: [MKPointAnnotation] = [] {
        didSet{
            self.updateMap()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.map.delegate = self
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        let location: CLLocation = locations.last as CLLocation
        
        let pointAnnotetion = MKPointAnnotation()
        pointAnnotetion.coordinate.latitude = location.coordinate.latitude
        pointAnnotetion.coordinate.longitude = location.coordinate.longitude
        
        self.pointAnnotetions.append(pointAnnotetion)
    }
    
    func updateMap() {
        let annotetion = self.pointAnnotetions.last! as MKPointAnnotation
        
        self.map.centerCoordinate = annotetion.coordinate
        self.map.addAnnotation(annotetion)
        
        if self.pointAnnotetions.count == 1 {
            self.map.setRegion(MKCoordinateRegion(center: annotetion.coordinate, span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)), animated: false)
        }
    }
}