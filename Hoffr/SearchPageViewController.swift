//
//  SearchPage1.0ViewController.swift
//  Hoffr
//
//  Created by admin on 14/12/2015.
//  Copyright © 2015 admin. All rights reserved.
//

import Foundation
import UIKit

class SearchPageViewController: UIViewController, UITableViewDataSource, NSURLConnectionDelegate, UITableViewDelegate {
    
    var numberOfCells = 5
    var rows: Int = 0
    let cellTableIdentifier = "CellTableIdentifier"
    let viewPropertySegueIdentifier = "ShowViewListingSegue"
    @IBOutlet var tableView: UITableView!
    var searchController: UISearchController!
    //var listings: [NSDictionary] = [NSDictionary]() //where we keep the listings to display in the cells
    var listings: [Listing] = [Listing]()
    let apiManager = APIManager.sharedInstance
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //populate listing array with random listings
        let query: String = "api/get_random_sale_listing"
        
        for var index=0; index < numberOfCells; index++ {
            print(index)
            apiManager.get_JSON(query){result -> Void in
                if let response = result as NSDictionary! {
                    let newListing = Listing(dictionary: response)
                    self.listings.append(newListing)
                    //self.listings.append(newListing)
                    /*if let dict = response["listing_desc"] as! String! {
                    //print(dict)
                    
                    }else{
                        print("Null dict??")
                    }*/
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
    
    //MARK: - UITableViewDelegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        print(row)
        self.performSegueWithIdentifier("ShowViewListingSegue", sender: tableView.cellForRowAtIndexPath(indexPath))
        
    }
    
    //=====================================================================================================
    //tableView Data source methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //FOR NOW ONLY 5
        return self.rows
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("trying cell")
        let cell = tableView.dequeueReusableCellWithIdentifier(cellTableIdentifier, forIndexPath: indexPath) as! SearchPageListingCell
        
        //let aListing: NSDictionary? = listings[indexPath.row ]
        let aListing: Listing = listings[indexPath.row]
        
        //get the listing description
        
        cell.descriptionLabel.text = aListing.getListingDescription()
        
        //get the image to be displayed
        let yup = aListing.getPropertyID()
        print("HEREREREREREHHUGOSDHGSH  \(yup)")
        if let prop_id = aListing.getPropertyID(){
             let photo_id = aListing.getListingPhotoID()!
                cell.property_id = prop_id                 
                let imageQuery = "property_\(prop_id)/\(photo_id).jpg"
                print(imageQuery)
                self.apiManager.get_image(imageQuery){image -> Void in
                    if let im = image as UIImage!{
                        cell.listingImage.image = im
                    }
                    else{
                        print("image cock up")
                    }
                }
            
        }
        //set the listing id for the cell
        if let list_id = aListing.getListingID(){
            let listInt: Int? = list_id //as? Int
            cell.listing_id = listInt
        }
        print("making cell")
        return cell
    }
    
    //--------------------------------------------------------------------
    //MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("preping segue")
        if segue.identifier == viewPropertySegueIdentifier {
            print("working")
            if let viewListing = segue.destinationViewController as? ViewListingController{
                let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
                viewListing.listing = listings[indexPath!.row] //pass the listing data to the viewListingController
            }
        }
    }
    
    
    
    
}