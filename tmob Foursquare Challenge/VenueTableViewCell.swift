//
//  VenueTableViewCell.swift
//  tmob Foursquare Challenge
//
//  Created by Efe Helvacı on 15.04.2017.
//  Copyright © 2017 Efe Helvacı. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    func setCellProperties(venue: Venue) {
        nameLabel.text = venue.name
        addressLabel.text = venue.address
        cityLabel.text = venue.city
        countryLabel.text = venue.country
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
