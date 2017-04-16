//
//  Location.swift
//  tmob Foursquare Challenge
//
//  Created by Efe Helvacı on 16.04.2017.
//  Copyright © 2017 Efe Helvacı. All rights reserved.
//

import Foundation

struct Location {
    var lat : Double?
    var lon : Double?
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}
