//
//  User.swift
//  Practice
//
//  Created by Aussawin Kaokum on 11/23/2560 BE.
//  Copyright © 2560 Aussawin Kaokum. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class User{
    var username: String
    var password: String
    var latitude: Double
    var longtitude: Double
    init(username: String, password: String, latitude: Double, longtitude: Double) {
        self.username = username
        self.password = password
        self.latitude = latitude
        self.longtitude = longtitude
    }
}
