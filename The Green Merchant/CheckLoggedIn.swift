//
//  ManageOrdersViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 13/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire

var usercat = ""




class CheckLoggedIn: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogged()
    }
    
    //Log in Success!
    //Logged in as Seller
    func checkLogged() {
        if usercat == "Logged in Success!" {
            let controller:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewTabBar") as UIViewController
            self.present(controller, animated: true, completion: nil)
        } else if usercat == "Logged in as Seller" {
            let controller:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SellerMainVC") as UIViewController
            self.present(controller, animated: true, completion: nil)
        } else {
            let controller:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoggedOutVC") as UIViewController
            self.present(controller, animated: true, completion: nil)
        }
    }


}
