//
//  ItemsTableViewCell.swift
//  The Green Merchant
//
//  Created by Paul Austria on 02/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {

    @IBOutlet var itemNameHolder: UILabel!
    @IBOutlet var itemPriceHolder: UILabel!
    @IBOutlet var itemSellerName: UILabel!
    @IBOutlet var itemRemaining: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
