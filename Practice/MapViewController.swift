//
//  MapViewController.swift
//  Practice
//
//  Created by Aussawin Kaokum on 11/23/2560 BE.
//  Copyright © 2560 Aussawin Kaokum. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var user: User!
    
    func addPinMap(location: CLLocationCoordinate2D, title: String, subtitle: String) {
        
        let annotaion = MapMarker(coordinate: location, title: title, subtitle: subtitle)
        mapView.addAnnotation(annotaion)
        setCenterOfMapToLocation(location: location)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        let location1 = CLLocationCoordinate2DMake(user.latitude, user.longtitude)
        addPinMap(location: location1, title: user.username, subtitle: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCenterOfMapToLocation(location: CLLocationCoordinate2D) {
        let coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }

}
