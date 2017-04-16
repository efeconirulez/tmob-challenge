//
//  Venue.swift
//  tmob Foursquare Challenge
//
//  Created by Efe Helvacı on 13.04.2017.
//  Copyright © 2017 Efe Helvacı. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol VenueUpdateDelegate {
    func updateVenueViews()
}

class Venue: NSObject {
    var id : String!
    var name : String!
    var city : String!
    var country : String!
    var address : String = ""
    var photoURL : String? {
        didSet {
            delegate?.updateVenueViews()
        }
    }
    var tips = [String]() {
        didSet {
            delegate?.updateVenueViews()
        }
    }
    var location : Location!
    
    // Tips and PhotoURL are fetching async, so if they got updated while the venue details are opened they will be updated accordingly
    var delegate : VenueUpdateDelegate?
    
    init(json: JSON) {
        self.id = json["id"].string ?? "-1"
        self.name = json["name"].string ?? "Venue with no name"
        self.city = json["location"]["city"].string ?? json["location"]["state"].string ?? ""
        self.country = json["location"]["country"].string ?? ""
        self.address = json["location"]["address"].string ?? ""
        self.location = Location(lat: Double(json["location"]["lat"].stringValue)!, lon: Double(json["location"]["lng"].stringValue)!)
        
        // TODO: - We may get address from reverse geolocation using lat and lng values
    }
}
