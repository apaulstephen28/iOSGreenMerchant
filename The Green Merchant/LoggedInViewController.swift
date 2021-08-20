//
//  LoggedInViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 10/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire
var thisUser = ""
class LoggedInViewController: UIViewController {

    let URL_SELECT_USER = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/select_user_to_frontend.php"
    
    @IBOutlet var lblUserOutlet: UILabel!
    @IBOutlet var btnLogoutOutlet: UIButton!
    @IBOutlet var btnChangePassOutlet: UIButton!
    @IBOutlet var btnAboutUsOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showProfile()
        btnLogoutOutlet.layer.cornerRadius = 20.0
        btnChangePassOutlet.layer.cornerRadius = 20.0
        btnAboutUsOutlet.layer.cornerRadius = 20.0
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
        
    }
    func showProfile() {
        
        let params: Parameters = ["user_firstname":username]
        Alamofire.request(URL_SELECT_USER, method:.post, parameters: params).responseJSON {
            response in
            print(response)
            if let result = response.result.value as? [Dictionary<String,AnyObject>] {
                for dict in result {
                    print(dict)
                    if let name = dict["user_firstname"] as? String{
                        self.lblUserOutlet.text = name
                        
                    }
                }
            }
        }
        
    }
    
    
    @IBAction func btnLogOut(_ sender: Any) {
        
        let mbox = UIAlertController(title: "LOGGING OUT", message:"Are you sure you want to log out?", preferredStyle: UIAlertController.Style.alert)
        mbox.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) -> Void in
            username = ""
            let controller:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoggedOutVC") as UIViewController
            self.present(controller, animated: true, completion: nil)
        }))
        
        self.present(mbox, animated: true)
        
    }
    
}
