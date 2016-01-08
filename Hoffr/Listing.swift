//
//  Listing.swift
//  Hoffr
//
//  Created by admin on 28/12/2015.
//  Copyright © 2015 admin. All rights reserved.
//

import UIKit

//use this in the searchpage listing array instead of NSDictionaries, parse and store all the variables here
class Listing: NSObject {
    
    private var listingDictionary = NSDictionary()
    private var listing_id: Int = 0
    private var property_id: Int = 0
    private var listing_description: String = "No description"
    private var listing_photo: Int = 0
    
    override init(){}
    
    convenience init(dictionary: NSDictionary){
        self.init()
        listingDictionary = dictionary
        print("init called")
        //init listing_id
        if let list_id = listingDictionary["listing_id"] as! String!{
            
            listing_id = Int(list_id)!
            print("listing_id is \(listing_id)")
        }
        
        //init prop_id
        if let prop_id = listingDictionary["property_id_for_sale_listing_fk"] as! String!{
            property_id = Int(prop_id)!
            print(property_id)
        }
        else if let prop_id = listingDictionary["property_id_for_rent_listing_fk"]{
            property_id = (prop_id as? Int)!
        }
        else{
            
            if let prop_id = listingDictionary["property_id_room_listing_fk"]{
                property_id = (prop_id as? Int)!
            }
            else{
                print("cockup with listing property id")
            }
        }
        
        //inir dscription
        if let prop_id = listingDictionary["listing_desc"]{
            listing_description = prop_id as! String
        }
        
        //init listing photo id
        if let photo_id = listingDictionary["listing_photo"] as! String!{
            listing_photo = Int(photo_id)!
        }
        
    }
    
    
    //getters
    func getListingID() -> Int?{
        return listing_id
    }
    
    func getPropertyID() -> Int?{
        return property_id
    }
    
    func getListingDescription() -> String{
        return listing_description
    }
    
    func getListingPhotoID() -> Int?{
        return listing_photo
    }

}
