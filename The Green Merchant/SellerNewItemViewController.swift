//
//  SellerNewItemViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 16/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire

class SellerNewItemViewController: UIViewController, UITextFieldDelegate {

    var thisName = sellerNameStorage
    var thisAdd = sellerAddressStorage
    var thisCon = sellerContactStorage
    var thisEm = sellerEmailStorage
    var thisOrder = 0
    var totalPrice:Double = 0
    var orderQty:Double = 0
    var truePrice:Double = 0
    var changingQty:Int = 0
    
    @IBOutlet var txtNewItemName: UITextField!
    @IBOutlet var txtNewItemPrice: UITextField!
    @IBOutlet var txtNewItemQty: UITextField!
    @IBOutlet var txtNewItemDesc: UITextView!
    
    @IBOutlet var saveOutlet: UIButton!
    @IBOutlet var counterQty: UIStepper!
    
    let URL_NEW_ITEM = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/create_new_item.php"
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For numers
        if textField == txtNewItemPrice {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveOutlet.layer.cornerRadius = 20.0
        self.txtNewItemPrice.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: "dismissKeyboard")
        self.hideKeyboardWhenTappedAround()
        
        view.addGestureRecognizer(tap)
    }

    @IBAction func btnQuantity(_ sender: UIStepper) {
       txtNewItemQty.text! = String(Int(sender.value))
        
    }
    
    @IBAction func btnNewItemSave(_ sender: Any) {
        let parameters:Parameters = ["item_name":txtNewItemName.text!, "quantity":txtNewItemQty.text!, "price":txtNewItemPrice.text!, "description":txtNewItemDesc.text!, "seller_name":thisName, "seller_address":thisAdd, "seller_contact":thisCon, "seller_email":thisEm, "item_order":thisOrder, "seller_username":username]
        Alamofire.request(URL_NEW_ITEM, method:.post, parameters: parameters).responseJSON {
            response in
            print(response)
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                print(jsonData)
                let message = jsonData.value(forKey: "message") as? String
                if message != "Item created successfully" {
                    let mbox = UIAlertController(title: message, message:"", preferredStyle: UIAlertController.Style.alert)
                    mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil))
                    self.present(mbox,animated: true, completion: nil)
                } else {
                    sellingNameStorage.append(self.txtNewItemName.text!)
                    sellingPriceStorage.append(self.txtNewItemPrice.text!)
                    sellingQtyStorage.append(self.txtNewItemQty.text!)
                    sellingOrderStorage.append(String(self.thisOrder))
                  
                    let success = UIAlertController(title: message, message:"", preferredStyle: UIAlertController.Style.alert)
                    success.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) -> Void in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(success,animated: true, completion: nil)
                    
                }
                self.txtNewItemName.text = ""
                self.txtNewItemPrice.text = ""
                self.txtNewItemQty.text = "50"
                self.txtNewItemDesc.text = ""
            }
            
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
