//
//  MapTableViewCell.swift
//  tmob Foursquare Challenge
//
//  Created by Efe Helvacı on 15.04.2017.
//  Copyright © 2017 Efe Helvacı. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    
    func addPinToCenter(location: Location) {
        let centerLocation = CLLocationCoordinate2DMake(location.lat!, location.lon!)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        
        let pin = MKPointAnnotation()
        pin.coordinate = centerLocation
        mapView.addAnnotation(pin)
        mapView.region = MKCoordinateRegion(center: centerLocation, span: mapSpan)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
