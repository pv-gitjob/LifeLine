//
//  UsersLocationAnnotation.swift
//  LifeLine
//
//  Created by Stephen Baity on 4/30/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit
import MapKit

class UsersLocationAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let subtitle: String?
    var title: String?
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
    
    func SetTitle(newTitle: String) {
        title = newTitle
    }
}
