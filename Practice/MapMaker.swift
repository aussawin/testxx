//
//  MapMaker.swift
//  Practice
//
//  Created by Aussawin Kaokum on 11/24/2560 BE.
//  Copyright © 2560 Aussawin Kaokum. All rights reserved.
//

import Foundation
import MapKit

class MapMarker: NSObject, MKAnnotation{
    //การ mark จุดบน map => การทำ Annotation
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        super.init()
    }
}

