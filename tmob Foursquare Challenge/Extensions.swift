//
//  Extensions.swift
//  tmob Foursquare Challenge
//
//  Created by Efe Helvacı on 16.04.2017.
//  Copyright © 2017 Efe Helvacı. All rights reserved.
//

import UIKit

extension String {
    // Calculates and returns the height of the string based on its width and font
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
