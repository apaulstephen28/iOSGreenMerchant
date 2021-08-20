//
//  ThirdViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 01/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire
var username = ""
var category = ""
var seller = ""
class ThirdViewController: UIViewController {

    
    @IBOutlet weak var btnLoginOutlet: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    let URL_SELECT_USER = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/select_user_to_frontend.php"
    let URL_USER_REGISTER="http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/log_in.php";
    let URL_USER="http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/thisUser.php";
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLoginOutlet.layer.cornerRadius = 10.0
        seller = ""
        username = ""
        let tap: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: "dismissKeyboard")
        self.hideKeyboardWhenTappedAround()
        
        view.addGestureRecognizer(tap)
        
        
    }
    func saveUserCategory() {
        let params: Parameters = ["user_firstname":username]
        Alamofire.request(URL_SELECT_USER, method:.post, parameters: params).responseJSON {
            response in
            print(response)
            if let result = response.result.value as? [Dictionary<String,AnyObject>] {
                for dict in result {
                    print(dict)
                    if let cat = dict["user_category"] as? String{
                        category = cat
                        print(category)
                    }
                }
            }
        }
    }
    
    
    

    
    
    @IBAction func btnLogin(_ sender: Any) {
        username = self.txtUsername.text!

        let parameters:Parameters=["username":txtUsername.text!,"password":txtPassword.text!]
        Alamofire.request(URL_USER_REGISTER, method:.post,
                          parameters:parameters).responseJSON
            {
                response in
                print(response)
                //getting the json value from the server
                if let result=response.result.value{
                    //converting it as NSDictionary
                    let jsonData=result as! NSDictionary
                    print(jsonData)
                    let message = jsonData.value(forKey: "message") as? String
                        if (jsonData.value(forKey: "message") as! String? == "Log in Success!"){
                            print("Login Success")
                            usercat = message!
                            //displaying the message in msgbox
                            let mbox = UIAlertController(title: message, message: "", preferredStyle: UIAlertController.Style.alert)
                            mbox.addAction(UIAlertAction(title: "CONTINUE", style: UIAlertAction.Style.default, handler: {(action) -> Void in
                                self.performSegue(withIdentifier: "toMainSegue", sender: self)
//                                let controller:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewTabBar") as UIViewController
//                                self.present(controller, animated: true, completion: nil)
                            }))
                        self.present(mbox, animated: true)
                        } else if (jsonData.value(forKey: "message") as! String? == "Logged in as Seller") {
                            usercat = message!
                            //displaying the message in msgbox
                            let mbox = UIAlertController(title: message, message: "", preferredStyle: UIAlertController.Style.alert)
                            mbox.addAction(UIAlertAction(title: "CONTINUE", style: UIAlertAction.Style.default, handler: {(action) -> Void in
                                self.performSegue(withIdentifier: "toSellerSegue", sender: self)
//                                let controller:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewTabBar") as UIViewController
//                                self.present(controller, animated: true, completion: nil)
                            }))
                            self.present(mbox, animated: true)
                    } else if (self.txtUsername.text == "")||(self.txtPassword.text == "")  {
                    let mbox = UIAlertController(title: "WARNING", message: "Please fill out all fields!", preferredStyle: UIAlertController.Style.alert)
                    mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(mbox, animated: true)
                } else {
                    print("ERROR")
                    let mbox = UIAlertController(title: "NOTICE", message: jsonData.value(forKey: "message") as! String?, preferredStyle: UIAlertController.Style.alert)
                    mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(mbox, animated: true)
                }
        }
                    
              //self.lblMessage.text=jsonData.value(forKey:"message") as! String?
                //clear textfield’s content once record has been added
                self.txtUsername.text="";
                self.txtPassword.text="";
                }
      
        }
    
   
    
    @IBAction func btn_MissionVision(_ sender: UIButton) {
        let mbox = UIAlertController(title: "Mission and Vision", message: "\nMission \n\n To bridge simple household to manufacturers to sell their biodegradable products to be used as fertilizers, to achieve organic way of farming to maintain the freshness, safeness of fruits and vegetables. To avoid using chemical fertilizer that may harm peoples health. \n\n Vision\nThe organic way of farming, keeping safe of the fruits and vegetables, Helping manufacturers to avoid chemical fertilizers. And turning trash into the cash from simple household. That will benefited by everyone.", preferredStyle: UIAlertController.Style.alert)
        mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(mbox, animated: true)
    }
    
    @IBAction func btn_howTouse(_ sender: UIButton) {
        let mbox = UIAlertController(title: "Help Menu", message: "\nSign up & Login \n\n1. To create a new a account select the “SIGN UP” button at the bottom of the login in screen.\n2. Agreeing to our Terms & Conditions will bring you to our final section of signing up.\n3. Please input accurate information while creating your account.\n4. Finalize by confirming the creation of your account, this will automatically send you back to the Login Screen.\n5. You can now proceed to our office anytime to activate your account. NOTE: You must bring with you your legal documents.", preferredStyle: UIAlertController.Style.alert)
        mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(mbox, animated: true)
    }
}

extension UIViewController{
    func hideKeyboardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }



}
