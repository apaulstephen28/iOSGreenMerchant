//
//  ChangePassViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 13/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire

var message = "SUCCESS"
var pass = ""
var retrieve_Uname = ""
var retrieve_Pword = ""

class ChangePassViewController: UIViewController {

    let URL_SELECT_USER = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/select_user_to_frontend.php"
    let URL_CHANGE_PASS = "http://ap1902-001-site1.htempurl.comiOS_FinalProject/process1/changepassword2.php";
    @IBOutlet var txtConfirmPassword: UITextField!
    @IBOutlet var txtNewPassword: UITextField!
    @IBOutlet var txtOldPassword: UITextField!
    @IBOutlet var btnSaveOutlet: UIButton!
    
    @IBOutlet var name: UILabel!
    var pass = ""
    var old = ""
    var confirm = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSaveOutlet.layer.cornerRadius = 20.0
        name.text! = username
        showProfile()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: "dismissKeyboard")
        self.hideKeyboardWhenTappedAround()
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
  

    func showProfile() {
        
        let params: Parameters = ["user_firstname":username]
        Alamofire.request(URL_SELECT_USER, method:.post, parameters: params).responseJSON {
            response in
            print(response)
            if let result = response.result.value as? [Dictionary<String,AnyObject>] {
                for dict in result {
                    print(dict)
                    let name = dict["username"] as? String
                    self.name.text = name
                    let pw = dict["password"] as? String
                    
                    retrieve_Uname = name!
                    retrieve_Pword = pw!
                }
            }
        }
        
    }


    @IBAction func btnUpdate(_ sender: Any) {
        confirm = txtNewPassword.text!
        if ((txtNewPassword.text!) == (txtConfirmPassword.text!) && (retrieve_Pword == txtOldPassword.text!)) {
            let parameters: Parameters = ["username": username, "password" : confirm]
            
            Alamofire.request(URL_CHANGE_PASS, method:.post, parameters:parameters).responseJSON
                {
                    (response) in
                    print(response)
            }
            let alert = UIAlertController (title: "Password update", message: message, preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
                UIAlertAction in NSLog ("OK Pressed")
            self.navigationController?.popViewController(animated: true)
            }
            alert.addAction (okAction)
            self.present(alert, animated: true, completion:nil)
        } else {
            let alert = UIAlertController (title: "error", message: "message", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}
