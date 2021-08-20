//
//  ViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 01/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func btnbuyer(_ sender: Any) {
        performSegue(withIdentifier: "buyer", sender: self)
    }
    
    @IBAction func btnSeller(_ sender: Any) {
        performSegue(withIdentifier: "seller", sender: self)
        
    }
    
    @IBAction func btn_back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

