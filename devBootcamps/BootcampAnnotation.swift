//
//  BootcampAnnotation.swift
//  devBootcamps
//
//  Created by Mike Piatin on 11/04/2016.
//  Copyright © 2016 Aurora Software. All rights reserved.
//

import Foundation
import MapKit

class BootcampAnnotation: NSObject, MKAnnotation {
    
    var coordinate = CLLocationCoordinate2D()
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        
    }
    
}