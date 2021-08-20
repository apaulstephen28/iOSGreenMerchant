//
//  ChangePassSellerViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 25/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit

class ChangePassSellerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: "dismissKeyboard")
        self.hideKeyboardWhenTappedAround()
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
