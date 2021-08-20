//
//  SellerMainViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 13/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire

var sellerNameStorage = ""
var sellerAddressStorage = ""
var sellerContactStorage = ""
var sellerEmailStorage = ""

class SellerMainViewController: UIViewController {

    @IBOutlet weak var txtPayable: UILabel!
    @IBOutlet weak var txtEarned: UILabel!
    @IBOutlet var lblSellerName: UILabel!
    
    let URL_SELECT_USER = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/select_user_to_frontend.php"
    let URL_ADD_ITEM = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/create_new_item.php"
    let URL_SELECT_COMM = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/select_comm.php"
    
    var TotalEarned = ""
    var TotalPayable = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showProfile()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        showCommission()
    }
    
    @IBAction func btnPayable(_ sender: Any) {
        let mbox = UIAlertController(title: "TOTAL PAYABLE", message:"Payable is the amount of commission that the developers will collect from you. It's value is the ten percent(10%) of your income.\nIf you have questions, you may contact the administrators or go to our office.", preferredStyle: UIAlertController.Style.alert)
        mbox.addAction(UIAlertAction(title: "I Understand.", style: UIAlertAction.Style.default, handler: nil))
        self.present(mbox, animated: true)
    }
    
    
    @IBAction func btnSellerLogout(_ sender: Any) {
        let mbox = UIAlertController(title: "LOGGING OUT", message:"Are you sure you want to log out?", preferredStyle: UIAlertController.Style.alert)
        mbox.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) -> Void in
            username = ""
            usercat = ""
            let controller:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoggedOutVC") as UIViewController
            self.present(controller, animated: true, completion: nil)
        }))
        
        self.present(mbox, animated: true)
    }
    
    func removeArrayContent() {
        sellingNameStorage.removeAll()
        sellingPriceStorage.removeAll()
        sellingQtyStorage.removeAll()
        sellingOrderStorage.removeAll()
    }
    
    func showCommission() {
        let parameters:Parameters = ["username":username]
        
        Alamofire.request(URL_SELECT_COMM, method:.post, parameters: parameters).responseJSON {
            
            response in
            
            print(response)
            
            if let result = response.result.value as? [Dictionary<String,AnyObject>] {
                
                for dict in result {
                    
                    print(dict)
                    
                    let tamount = dict["totalamount"] as? String
                    let tpayable = dict["tobecollected"] as? String
                    self.txtEarned.text! = "Php " + tamount! + ".00"
                    self.txtPayable.text! = "Php " + tpayable! + ".00"
                }
            }
        }
    }
    
    
    func showProfile() {
        let params: Parameters = ["user_firstname":username]
        
        Alamofire.request(URL_SELECT_USER, method:.post, parameters: params).responseJSON {
            
            response in
            
            print(response)
            
            if let result = response.result.value as? [Dictionary<String,AnyObject>] {
                
                for dict in result {
                    
                    print(dict)
                    let name = dict["user_firstname"] as? String
                    let add = dict["address"] as? String
                    let contact = dict["contact_num"] as? String
                    let email = dict["email_add"] as? String
                        self.lblSellerName.text = name
                    sellerNameStorage = name!
                    sellerAddressStorage = add!
                    sellerContactStorage = contact!
                    sellerEmailStorage = email!
                }
                
            }
            
        }
        
        
        
    }

}
