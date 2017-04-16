//
//  TipTableViewCell.swift
//  tmob Foursquare Challenge
//
//  Created by Efe Helvacı on 15.04.2017.
//  Copyright © 2017 Efe Helvacı. All rights reserved.
//

import UIKit

class TipTableViewCell: UITableViewCell {

    @IBOutlet weak var tipLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
