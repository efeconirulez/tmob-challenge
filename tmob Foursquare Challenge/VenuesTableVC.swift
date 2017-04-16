//
//  VenuesTableVC.swift
//  tmob Foursquare Challenge
//
//  Created by Efe Helvacı on 14.04.2017.
//  Copyright © 2017 Efe Helvacı. All rights reserved.
//

import UIKit
import FTIndicator
import CoreLocation

class VenuesTableVC: UITableViewController {

    var location : String?
    var type : String!
    var venues = [Venue]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var locationManager : CLLocationManager!
    var currentLocation : Location? {
        didSet {
            // After getting a current location monitoring will stop, 
            // then places will be queried with the current location
            locationManager.stopUpdatingLocation()
            getPlacesFromCurrentLocation(location: currentLocation!, type: type)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If user provides a location, places will queried with that location
        // Otherwise current location is needed
        if location != nil {
            getPlacesFromString(location: location!, type: type)
        } else {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as? VenueTableViewCell {
            
            cell.setCellProperties(venue: venues[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVenueVC") as? DetailVenueVC {
            detailVC.modalPresentationStyle = UIModalPresentationStyle.popover
            detailVC.preferredContentSize = CGSize(width: UIScreen.main.bounds.size.width-16, height: 495)
            detailVC.venue = venues[indexPath.row]
            
            let popoverController = detailVC.popoverPresentationController
            popoverController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            popoverController?.delegate = self
            popoverController?.sourceView = self.view
            popoverController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            present(detailVC, animated: true, completion: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}

// MARK: - Location Manager Delegate Methods

extension VenuesTableVC : CLLocationManagerDelegate {
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined,
             .restricted,
             .denied:
            // If status has not yet been determied || restricted || denied -> ask for authorization
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse,
             .authorizedAlways:
            // If authorized...
            manager.startUpdatingLocation()
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        self.currentLocation = Location(lat: locValue.latitude, lon: locValue.longitude)
    }
}

// MARK: - Popover Presentation Controller Delegate Methods

extension VenuesTableVC : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

// MARK: - Self implemented methods

extension VenuesTableVC {
    func getPlacesFromString(location : String, type : String) {
        FTIndicator.showProgressWithmessage("Loading")
        
        NetworkManager.sharedInstance.retrievePlaces(location: location, ll: nil, type: type, completion: { venues in
            self.venues = venues
            
            FTIndicator.dismissProgress()
        })
    }
    
    func getPlacesFromCurrentLocation(location : Location, type : String) {
        FTIndicator.showProgressWithmessage("Loading")
        
        NetworkManager.sharedInstance.retrievePlaces(location: nil, ll: location, type: type, completion: { venues in
            self.venues = venues
            
            FTIndicator.dismissProgress()
        })
    }
}
