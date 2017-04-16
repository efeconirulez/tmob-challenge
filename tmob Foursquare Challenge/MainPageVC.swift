//
//  MainPageVC.swift
//  tmob Foursquare Challenge
//
//  Created by Efe Helvacı on 14.04.2017.
//  Copyright © 2017 Efe Helvacı. All rights reserved.
//

import UIKit
import FTIndicator
import SwifterSwift

class MainPageVC: UIViewController {
    
    @IBOutlet weak var venueTypeTF: UITextField!
    @IBOutlet weak var venueLocationTF: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: (searchButton.width / 2.0) - 30, bottom: 0, right: 0)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        guard (venueTypeTF.text?.characters.count)! >= 3 else {
            FTIndicator.showInfo(withMessage: "Venue type should be more than 3 characters.")
            
            venueTypeTF.shake()
            return
        }
        
        performSegue(withIdentifier: "mainPageToListSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? VenuesTableVC else {
            print("Error : Segue destination is not the type of VenuesTableVC")
            return
        }

        if venueLocationTF.text != nil && (venueLocationTF.text?.characters.count)! > 0 {
            vc.location = venueLocationTF.text
        }
        vc.type = venueTypeTF.text!
        
        print("Venue Location : \(venueLocationTF.text!)")
        print("Venue Type : \(venueTypeTF.text!)")
    }

}
