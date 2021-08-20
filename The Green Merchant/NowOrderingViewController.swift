//
//  NowOrderingViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 17/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire



class NowOrderingViewController: UIViewController {
    
    var Oconfirmation = "WAITING FOR CONFIRMATION"
    var savedSeller = ""
    var Opassedname = ""
    var Opassedprice = ""
    var Opassedqqty = ""
    var Opasseddesc = ""
    var Opassedseller = ""
    var Opassednumber = ""
    var Opassedemail = ""
    var totalPrice:Double = 0
    var orderQty:Double = 0
    var truePrice:Double = 0
    var changingQty:Int = 0
    var subtractStock:Int = 0
    
    //retrieved data to insert in tbl_orders
    var userFName = ""
    var userAddress = ""
    var userContact = ""
    var userEmail = ""
    var userLogin = ""
    var orderCount = ""
    var itemId = ""
    
    var sellerFName = ""
    var sellerAddress = ""
    var sellerContact = ""
    var sellerEmail = ""
    var sellerLogin = ""
 
    let URL_PLACE_ORDER = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/new_order.php"
    let URL_ADD_ORDER = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/add_order.php"
    let URL_SELECT_BUYER = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/select_user_to_frontend.php"
    
    @IBOutlet var orderItemName: UILabel!
    @IBOutlet var orderItemPrice: UILabel!
    @IBOutlet var orderItemQty: UILabel!
    @IBOutlet var orderItemSeller: UILabel!
    @IBOutlet var orderSellerContactNo: UILabel!
    @IBOutlet var orderSellerEmail: UILabel!
    @IBOutlet var btnPlaceOrderOutlet: UIButton!
    @IBOutlet var txtOrderingQty: UITextField!
    @IBOutlet var lblTotalPrice: UILabel!
    @IBOutlet var btnOrderingOutlet: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buyerProfile()
        sellerProfile()
        orderItemName.text! = Opassedname
        orderItemPrice.text! = Opassedprice
        orderItemQty.text! = Opassedqqty
        orderItemSeller.text! = Opassedseller
        orderSellerContactNo.text! = Opassednumber
        orderSellerEmail.text! = Opassedemail
        btnOrderingOutlet.maximumValue = Double(orderItemQty.text!)!
        lblTotalPrice.text! = "" + Opassedprice + ""
        print(itemId)
        print(savedSeller)
        totalPrice = truePrice * 1
        changingQty = 50
        // Do any additional setup after loading the view.
    }
    
    func buyerProfile() {
        
        let params: Parameters = ["user_firstname":username]
        Alamofire.request(URL_SELECT_BUYER, method:.post, parameters: params).responseJSON {
            response in
            print(response)
            if let result = response.result.value as? [Dictionary<String,AnyObject>] {
                for dict in result {
                    print(dict)
                    let name = dict["user_firstname"] as? String
                    let add = dict["address"] as? String
                    let contact = dict["contact_num"] as? String
                    let email = dict["email_add"] as? String
                    
                    self.userFName = name!
                    self.userAddress = add!
                    self.userContact = contact!
                    self.userEmail = email!
                    self.userLogin = username
                }
            }
        }
        
    }
    
    func sellerProfile() {
        
        let params: Parameters = ["user_firstname":savedSeller]
        Alamofire.request(URL_SELECT_BUYER, method:.post, parameters: params).responseJSON {
            response in
            print(response)
            if let result = response.result.value as? [Dictionary<String,AnyObject>] {
                for dict in result {
                    print(dict)
                    let name = dict["user_firstname"] as? String
                    let add = dict["address"] as? String
                    let contact = dict["contact_num"] as? String
                    let email = dict["email_add"] as? String
                    
                    self.sellerFName = name!
                    self.sellerAddress = add!
                    self.sellerContact = contact!
                    self.sellerEmail = email!
                    //self.sellerLogin = uname!
                }
            }
        }
    }
    
    func OrderStockChange() {
        let id = itemId
        let newOrder = String(Int(orderCount)! + 1)
        let newQty = String(subtractStock)
        let params1:Parameters = ["id":id, "quantity":newQty, "item_order":newOrder]
        Alamofire.request(URL_ADD_ORDER, method:.post, parameters: params1).responseJSON {
            response in
            print(response)
        }
        print(id)
        print(newOrder)
        print(newQty)
    }
    
    
    
    
    @IBAction func btnOrderingQuantity(_ sender: UIStepper) {
        txtOrderingQty.text! = String(Int(sender.value))
        changingQty = Int(sender.value)
        orderQty = Double(txtOrderingQty.text!)!/50
        totalPrice = orderQty * truePrice
        lblTotalPrice.text = "Php " + String(totalPrice) + "0"
    }
    
    @IBAction func btnPlaceOrder(_ sender: Any) {
        subtractStock = Int(Opassedqqty)! - changingQty
        
        let parameters:Parameters = ["order_itemname":Opassedname, "order_quantity":changingQty, "order_total":totalPrice, "order_desc":Opasseddesc, "order_address":userAddress, "order_contact":userContact, "order_email":userEmail, "seller_address":sellerAddress, "seller_contact":sellerContact, "seller_email":sellerEmail, "buyer_firstname":userFName, "seller_firstname":sellerFName, "buyer_username":username, "seller_username":savedSeller, "confirmation":Oconfirmation]
        Alamofire.request(URL_PLACE_ORDER, method:.post, parameters: parameters).responseJSON {
            response in
            print(response)
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                print(jsonData)
                let message = jsonData.value(forKey: "message") as? String
                if message != "Successfully ordered the item" {
                    let mbox = UIAlertController(title: message, message:"", preferredStyle: UIAlertController.Style.alert)
                    mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil))
                    self.present(mbox,animated: true, completion: nil)
                } else {
                    
                    let success = UIAlertController(title: message, message:"", preferredStyle: UIAlertController.Style.alert)
                    
                    success.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) -> Void in
                        self.savedSeller = ""
                        self.OrderStockChange(); self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(success,animated: true, completion: nil)
                    
                }
            }
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
