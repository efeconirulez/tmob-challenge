//
//  Venue.swift
//  tmob Foursquare Challenge
//
//  Created by Efe Helvacı on 13.04.2017.
//  Copyright © 2017 Efe Helvacı. All rights reserved.
//

import Foundation
import SwiftyJSON

class Venue: NSObject {
    var id : String!
    var name : String!
    var city : String!
    var country : String!
    var address : String = ""
    var photoURL : String!
    var tips = [String]()
    var location : Location!
    
    init(json: JSON) {
        self.id = json["id"].string ?? "-1"
        self.name = json["name"].string ?? "Venue with no name"
        self.city = json["location"]["city"].string ?? json["location"]["state"].string ?? ""
        self.country = json["location"]["country"].string ?? ""
        self.address = json["location"]["address"].string ?? ""
        self.location = Location(lat: json["location"]["lat"].stringValue.double!, lon: json["location"]["lng"].stringValue.double!)
        
        // Or we may get address from reverse geolocation json["location"]["lat"] and json["location"]["lng"]
    }
}
