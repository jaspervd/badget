//
//  Settings.swift
//  Badget
//
//  Created by Jasper Van Damme on 03/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CoreLocation

struct Settings {
    static let bgColor = UIColor(red: 252/255, green: 240/255, blue: 222/255, alpha: 1)
    static let apiUrl = "http://student.howest.be/jasper.van.damme/20142015/MA4/BADGET/api"
    static let startDate = NSDate(timeIntervalSince1970: 1440057600) // 1440057600: 20/08/15 08:00
    static let secondsEndDay = 64800 // 64800: 18h
    static let endDate = NSDate(timeIntervalSince1970: 1440266400) // 1440266400: 22/08/15 18:00
    static let currentDate = NSDate(timeIntervalSince1970: 1440168981) // 1440168981: 21/08/15 14:56
    static let randstadCoords = CLLocationCoordinate2D(latitude: 50.8265950, longitude: 3.2632970)
}