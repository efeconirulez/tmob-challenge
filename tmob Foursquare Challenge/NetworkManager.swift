//
//  NetworkManager.swift
//  tmob Foursquare Challenge
//
//  Created by Efe Helvacı on 13.04.2017.
//  Copyright © 2017 Efe Helvacı. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager : NSObject {
    // Network Manager is a singleton
    static let sharedInstance = NetworkManager()
    private override init() {}
    
    // Client ID and Secret retrieved from Foursquare
    // This is not the best way to keep them but anyways
    let baseURL : String = "https://api.foursquare.com/v2/"
    let client_ID : String = "MQ5JWDHLVEZ325NRCJED0RHJMDXK1P5R03SCP3JONI4ZBESR"
    let client_secret : String = "IPUCDDWACSVWGS0LUBTMPMD24ZWMPVYACX3HLW3VANGGKK0X"
    
    // Foursquare API needs version parameter, v, which is the current date with a date format like this
    var version : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYmmdd"
        
        return dateFormatter.string(from: Date())
    }
    
    func retrievePlaces(location: String?, ll: Location?, type: String, completion: @escaping ([Venue]) -> Void) -> Void {
        
        var fullURL = ""
        var places = [Venue]()
        
        // Custom location or current location must be identfied or it will return an empty array
        // According to identified locaiton full URL is getting created
        if location != nil {
            fullURL = "\(baseURL)venues/search?client_id=\(client_ID)&client_secret=\(client_secret)&near=\(location!)&query=\(type)&v=\(version)"
        } else if ll != nil {
            fullURL = "\(baseURL)venues/search?client_id=\(client_ID)&client_secret=\(client_secret)&ll=\(ll!.lat!),\(ll!.lon!)&query=\(type)&v=\(version)"
        } else {
            print("Error : No location name, nor current location is provided.")
            completion(places)
            return
        }
        
        // Alamofire request with the URL provided
        Alamofire.request(fullURL).responseJSON(completionHandler: { response in
            guard response.result.isSuccess else {
                print("Error : Error while retrieving places from URL = \(fullURL)")
                completion(places)
                return
            }
            
            guard let responseData = response.data else {
                print("Error : Data that recieved from the Foursquare API is not valid.")
                completion(places)
                return
            }
            
            let json = JSON(data: responseData)
            
            // Iterate through the places retrieved from the API and append them to the response array.
            if let placesDataArray = json["response"]["venues"].array {
                for place in placesDataArray {
                    let _place = Venue(json: place)
                    
                    // Photos are requested from API, using place's ID
                    // This is an async call but handled by using update delegation in Venue
                    self.retrievePhoto(from: _place.id, completion: { (url) in
                        _place.photoURL = url
                    })
                    
                    // Tips are requested from API, using place's ID
                    // Async as well
                    self.retrieveTips(from: _place.id, completion: { (tips) in
                        _place.tips = tips
                    })
                    places.append(_place)
                }
            }
            
            // Response array is returned to the completion block
            completion(places)
        })
    }
    
    
    func retrievePhoto(from venueID : String, completion: @escaping (String) -> Void) -> Void {
        
        // If venue is not provided any photo, placeholder image will be returned
        var imageURL = "https://westhousevenues.co.uk/images/ui/venue-placeholder.jpg"
        let fullURL = "\(baseURL)venues/\(venueID)/photos?client_id=\(client_ID)&client_secret=\(client_secret)&limit=1&v=\(version)"
        
        Alamofire.request(fullURL).responseJSON(completionHandler: { response in
            guard response.result.isSuccess else {
                print("Error : Error while retrieving images from URL = \(fullURL)")
                completion(imageURL)
                return
            }
            
            guard let responseData = response.data else {
                print("Error : Data that recieved from the Foursquare API is not valid.")
                completion(imageURL)
                return
            }
            
            let json = JSON(data: responseData)
        
            // Getting only the first photo
            if let imagesDataArray = json["response"]["photos"]["items"].array {
                if let image = imagesDataArray.item(at: 0) {
                    imageURL = "\(image["prefix"])\(image["width"])x\(image["height"])\(image["suffix"])"
                }
            }

            // Image is returned to the completion block
            completion(imageURL)
        })
    }
    
    func retrieveTips(from venueID : String, completion: @escaping ([String]) -> Void) -> Void {
        var tips = [String]()
        let fullURL = "\(baseURL)venues/\(venueID)/tips?client_id=\(client_ID)&client_secret=\(client_secret)&sort=popular&v=\(version)"
        
        Alamofire.request(fullURL).responseJSON(completionHandler: { response in
            guard response.result.isSuccess else {
                print("Error : Error while retrieving tips from URL = \(fullURL)")
                completion(tips)
                return
            }
            
            guard let responseData = response.data else {
                print("Error : Data that recieved from the Foursquare API is not valid.")
                completion(tips)
                return
            }
            
            let json = JSON(data: responseData)
            
            // Iterate through tips and append all of them to the response array
            if let tipsDataArray = json["response"]["tips"]["items"].array {
                for tip in tipsDataArray {
                    tips.append(tip["text"].string!)
                }
            }
            
            // Tips are returned to the completion block
            completion(tips)
        })
    }
}
