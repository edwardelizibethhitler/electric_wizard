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
    
    var numberOfCells = 5
    var rows: Int = 0
    let cellTableIdentifier = "CellTableIdentifier"
    @IBOutlet var tableView: UITableView!
    var searchController: UISearchController!
    var listings: [NSDictionary] = [NSDictionary]() //where we keep the listings to display in the cells
    let apiManager = APIManager.sharedInstance
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //populate listing array with random listings
        let query: String = "get_random_sale_listing"
        
        for var index=0; index < numberOfCells; index++ {
            print(index)
            apiManager.get_JSON(query){result -> Void in
                if let response = result as NSDictionary! {
                    if let dict = response["listing_desc"] as! String! {
                    print(dict)
                    self.listings.append(response)
                    }else{
                        print("Null dict??")
                    }
                }
                self.rows = self.listings.count
                self.tableView.reloadData()
            }
            
        }
        //tell it what type of cell to use
        tableView.registerClass(SearchPageListingCell.self, forCellReuseIdentifier: cellTableIdentifier)
        let nib = UINib(nibName: "SearchPageListingCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: cellTableIdentifier)
        
        
        //create the search controller
        let resultsController = SearchResultsController()
        searchController = UISearchController(searchResultsController: resultsController)
        let searchBar = searchController.searchBar
        searchBar.scopeButtonTitles = ["For Sale", "For Rent","Rooms for Rent"]
        searchBar.placeholder = "Search properties on offr"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchController.searchResultsUpdater = resultsController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tableView Data source methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //FOR NOW ONLY 5
        return self.rows
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("trying cell")
        let cell = tableView.dequeueReusableCellWithIdentifier(cellTableIdentifier, forIndexPath: indexPath) as! SearchPageListingCell
        
        
        let aListing: NSDictionary? = listings[indexPath.row ]
        
        //get the listing description
        if let desc = aListing!["listing_desc"]{
            let descString = desc as! String
            cell.descriptionLabel.text = descString
        }
        else{
            cell.descriptionLabel.text = "No description found for listing"
        }
        //get the image to be displayed
        if let prop_id = aListing!["property_id_for_sale_listing_fk"]{
            if let photo_id = aListing!["listing_photo"]{
            let propInt = prop_id as! String
            let photoInt = photo_id as! String
            cell.property_id = prop_id as? Int
                
            let imageQuery = "property_\(propInt)/\(photoInt).jpg"
            self.apiManager.get_image(imageQuery){image -> Void in
                if let im = image as UIImage!{
                    cell.listingImage.image = im
                }
                else{
                    print("image cock up")
                }
            }
            }
        }
        //set the listing id for the cell
        if let list_id = aListing!["listing_id"]{
            let listInt: Int? = list_id as? Int
            cell.listing_id = listInt
        }
        
       
        print("making cell")
        return cell
    }
    
    
}