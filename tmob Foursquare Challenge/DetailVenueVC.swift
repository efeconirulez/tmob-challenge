//
//  DetailVenueVC.swift
//  tmob Foursquare Challenge
//
//  Created by Efe Helvacı on 15.04.2017.
//  Copyright © 2017 Efe Helvacı. All rights reserved.
//

import UIKit

class DetailVenueVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var venue : Venue!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        
        venue.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        case 2:
            return 1
        case 3:
            return venue.tips.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell") as? MapTableViewCell {
                cell.addPinToCenter(location: venue.location)
                return cell
            }
            break
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as? ImageTableViewCell {
                cell.setImage(url: venue.photoURL)
                return cell
            }
            break
        case 2:
            let cell = UITableViewCell()
            cell.textLabel?.text = venue.name
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = UIColor(hexString: "E6E6E6")
            return cell
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "tipCell") as? TipTableViewCell {
                cell.tipLabel.text = venue.tips[indexPath.row]
                return cell
            }
            break
        default:
            break
        }
        
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            // Map cell height
            return 145
        case 1:
            // Image cell height
            return 200
        case 3:
            // Tip cells heights' are dynamic referencing from tip text's length. And +30 for some breathing space.
            return venue.tips[indexPath.row].heightWithConstrainedWidth(UIScreen.main.bounds.size.width-16,
                                                                 font: UIFont.systemFont(ofSize: 14)) + 30
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 3 { return "Tips" }
        return nil
    }
}

// MARK: - Venue Update Delegate method

extension DetailVenueVC : VenueUpdateDelegate {
    func updateVenueViews() {
        tableView.reloadData()
    }
}
