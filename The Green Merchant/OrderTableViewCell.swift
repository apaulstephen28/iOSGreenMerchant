//
//  OrderTableViewCell.swift
//  The Green Merchant
//
//  Created by Paul Austria on 20/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet var orderNameStorage: UILabel!
    @IBOutlet var orderItemStorage: UILabel!
    @IBOutlet var orderQtyStorage: UILabel!
    @IBOutlet var orderTotalStorage: UILabel!
    @IBOutlet var orderActionStorage: UILabel!
    @IBOutlet weak var orderIdStorage: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
