//
//  ImageTableViewCell.swift
//  tmob Foursquare Challenge
//
//  Created by Efe Helvacı on 15.04.2017.
//  Copyright © 2017 Efe Helvacı. All rights reserved.
//

import UIKit
import Kingfisher

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var venueImageView: UIImageView!
    
    func setImage(url: String?) {
        venueImageView.kf.indicatorType = .activity
        venueImageView.kf.indicator?.startAnimatingView()
    
        guard url != nil else { return }
    
        venueImageView.kf.setImage(with: URL(string: url!))
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
