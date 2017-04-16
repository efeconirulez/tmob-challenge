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
        
        venueTypeTF.delegate = self
        venueLocationTF.delegate = self
        
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

        // Checks if user provided a custom location
        if venueLocationTF.text != nil && (venueLocationTF.text?.characters.count)! > 0 {
            vc.location = venueLocationTF.text
        }
        vc.type = venueTypeTF.text!
        
        print("Venue Location : \(venueLocationTF.text!)")
        print("Venue Type : \(venueTypeTF.text!)")
    }
}


// MARK: - Text Field Delegate Methods

extension MainPageVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // To prevent non-english characters
        let inverseSet = NSCharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXUZabcdefghijklmnopqrstuvwxyz").inverted
        
        let components = string.components(separatedBy: inverseSet)
        
        let filtered = components.joined(separator: "")
        
        return string == filtered
    }
    
    // User can search directly through keyboard's return button, which is 'Search' button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButton.sendActions(for: .touchUpInside)
        textField.resignFirstResponder()
        return false
    }
}
