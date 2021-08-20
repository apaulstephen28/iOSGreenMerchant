//
//  cartTableViewCell.swift
//  The Green Merchant
//
//  Created by Paul Austria on 13/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit

class cartTableViewCell: UITableViewCell {
    @IBOutlet var cartItemName: UILabel!
    @IBOutlet var cartItemPrice: UILabel!
    @IBOutlet var cartItemQty: UILabel!
    @IBOutlet var cartItemSeller: UILabel!
    @IBOutlet var cartItemConf: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
