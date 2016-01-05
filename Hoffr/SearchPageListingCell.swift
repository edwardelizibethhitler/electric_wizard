//
//  SearchPageListingCell.swift
//  Hoffr
//
//  Created by admin on 28/12/2015.
//  Copyright © 2015 admin. All rights reserved.
//

import UIKit

class SearchPageListingCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var listingImage: UIImageView!
    
    var property_id: Int?
    var listing_id: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
