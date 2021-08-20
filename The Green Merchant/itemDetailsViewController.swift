//
//  itemDetailsViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 12/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire



class itemDetailsViewController: UIViewController {

    @IBOutlet var lblItemNameDetail: UILabel!
    @IBOutlet var lblItemPriceDetail: UILabel!
    @IBOutlet var lblItemQuantityDetail: UILabel!
    @IBOutlet var lblItemDescDetail: UITextView!
    @IBOutlet var lblItemSellerName: UILabel!
    @IBOutlet var lblItemSellerContact: UILabel!
    @IBOutlet var lblItemSellerEmail: UILabel!
    
    
    var readyToCart_itemName = ""
    var readyToCart_itemPrice = ""
    var readyToCart_itemQuantity = ""
    var readyToCart_itemDescription = ""
    var readyToCart_itemSeller = ""
    var readyToCart_itemSellerAdd = ""
    var readyToCart_itemContact = ""
    var readyToCart_itemEmail = ""
    var readyToCart_itemOrder = ""
    var readyToCart_id = ""
    
    var passedId = ""
    var passedOrder = ""
    var passedItemName = ""
    var passedItemPrice = ""
    var passedItemQuantity = ""
    var passedItemDescription = ""
    var passedItemSellerName = ""
    var passedItemSellerAdd = ""
    var passedItemSellerContact = ""
    var passedItemSellerEmail = ""
    var buyerName = ""
    var passedSellerUname = ""
    
    
    
    let URL_SELECT_USER = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/select_user_to_frontend.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showProfile()
        lblItemNameDetail.text! = passedItemName
        lblItemPriceDetail.text! = "Php " + passedItemPrice + ".00"
        lblItemQuantityDetail.text! = passedItemQuantity
        lblItemDescDetail.text = passedItemDescription
        lblItemSellerName.text = passedItemSellerName
        lblItemSellerContact.text = passedItemSellerContact
        lblItemSellerEmail.text = passedItemSellerEmail
        
        readyToCart_itemName = passedItemName
        readyToCart_itemPrice = passedItemPrice
        readyToCart_itemQuantity = passedItemQuantity
        readyToCart_itemDescription = passedItemDescription
        readyToCart_itemSeller = passedItemSellerName
        readyToCart_itemSellerAdd = passedItemSellerAdd
        readyToCart_itemContact = passedItemSellerContact
        readyToCart_itemEmail = passedItemSellerEmail
        readyToCart_itemOrder = passedOrder
        readyToCart_id = passedId
        
        print(readyToCart_itemName)
        print(readyToCart_itemPrice)
        print(readyToCart_itemQuantity)
        print(readyToCart_itemDescription)
        print(readyToCart_itemSeller)
        print(readyToCart_itemSellerAdd)
        print(readyToCart_itemContact)
        print(readyToCart_itemEmail)
        print(buyerName)
        print(username)
        print(passedSellerUname)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(passedId)
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
                        self.buyerName = name
                    }
                }
            }
        }
        
    }
    
    
    

    @IBAction func btnOrderNow(_ sender: Any) {
        if lblItemQuantityDetail.text! == "0" {
            let mbox = UIAlertController(title: "message", message:"Out of stock!, Wait for the sellers update", preferredStyle: UIAlertController.Style.alert)
            mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil))
            self.present(mbox,animated: true, completion: nil)
        } else {
           performSegue(withIdentifier: "orderingSegue", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let orderingVC = segue.destination as! NowOrderingViewController
        orderingVC.Opassedname = lblItemNameDetail.text!
        orderingVC.Opassedprice = lblItemPriceDetail.text!
        orderingVC.Opassedqqty = lblItemQuantityDetail.text!
        orderingVC.Opasseddesc = lblItemDescDetail.text!
        orderingVC.Opassedseller = lblItemSellerName.text!
        orderingVC.Opassednumber = lblItemSellerContact.text!
        orderingVC.Opassedemail = lblItemSellerEmail.text!
        orderingVC.savedSeller = passedSellerUname
        orderingVC.orderCount = readyToCart_itemOrder
        orderingVC.itemId = passedId
        orderingVC.truePrice = Double(passedItemPrice)!
    }
}
