//
//  SearchPage1.0ViewController.swift
//  Hoffr
//
//  Created by admin on 14/12/2015.
//  Copyright © 2015 admin. All rights reserved.
//

import Foundation
import UIKit

class SearchPageViewController: UIViewController, UITableViewDataSource, NSURLConnectionDelegate {
    
    let cellTableIdentifier = "CellTableIdentifier"
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(SearchPageListingCell.self, forCellReuseIdentifier: cellTableIdentifier)
        let nib = UINib(nibName: "SearchPageListingCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: cellTableIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tableView Data source methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //FOR NOW ONLY 5
        let num = 5
        return num
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("trying cell")
        let cell = tableView.dequeueReusableCellWithIdentifier(cellTableIdentifier, forIndexPath: indexPath) as! SearchPageListingCell
        
        let apiManager = APIManager.sharedInstance
        let query: String = "get_random_sale_listing"
        //var prop_id: String?
        //var photo_id: String?
        
        //get property description and image from server
        apiManager.get_JSON(query){result -> Void in
            if let response = result as NSDictionary! {
                //get listing description
                if let desc = response["listing_desc"] {
                    let descString = desc as! String
                    cell.idLabel.text = "\(descString)"
                }
                else{
                    cell.idLabel.text = "no listing found description found"
                }
                //get prop and photo id
                if let prop_id = response["property_id_for_sale_listing_fk"]{
                    if let photo_id = response["listing_photo"]{
                        
                        let propInt = prop_id as! String
                        let photoInt = photo_id as! String
                            cell.property_id = prop_id as? Int
                            //create the query string that describes the photo location on the server
                            let imageQuery = "property_\(propInt)/\(photoInt).jpg"
                        
                            print(imageQuery)
                            apiManager.get_image(imageQuery){image -> Void in
                                if let im = image as UIImage!{
                                    cell.listingImage.image = im
                                }
                                else{
                                    print("image cock up")
                                }
                            }
                        }
                    }
                if let list_id = response["listing_id"]{
                    let listInt: Int? = list_id as? Int
                    cell.listing_id = listInt
                }
                
            }
        }
        
       
        
        print("making cell")
        return cell
    }
    
    
}