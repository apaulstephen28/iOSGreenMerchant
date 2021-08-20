//
//  SellerItemsTableViewCell.swift
//  The Green Merchant
//
//  Created by Paul Austria on 16/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit

class SellerItemsTableViewCell: UITableViewCell {
    
    
    
    var retrievedCartName:[String] = []
    var retrievedCartPrice:[String] = []
    var retrievedCartQty:[String] = []
    var retrievedCartDesc:[String] = []
    var retrievedCartSeller:[String] = []
    var retrievedCartAdd:[String] = []
    var retrievedCartContact:[String] = []
    var retrievedCartEmail:[String] = []
    var retrievedCartConf:[String] = []
    
    

    @IBOutlet var SlblItemName: UILabel!
    @IBOutlet var SlblItemPrice: UILabel!
    @IBOutlet var SlblItemQty: UILabel!
    @IBOutlet var SlblItemOrder: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
