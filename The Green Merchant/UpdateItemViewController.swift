//
//  UpdateItemViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 19/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire

class UpdateItemViewController: UIViewController {
    
    var id = ""
    var newName = ""
    var newPrice = ""
    var newQty = ""
    var newDesc = ""
    
    @IBOutlet var txtNewName: UITextField!
    @IBOutlet var txtNewPrice: UITextField!
    @IBOutlet var txtNewQty: UITextField!
    @IBOutlet var txtNewDesc: UITextView!
    @IBOutlet var newQtyStepper: UIStepper!
    @IBOutlet var btnSaveOutlet: UIButton!
    @IBOutlet var btnEditOutlet: UIButton!
    @IBOutlet var btnDeleteOutlet: UIButton!
    
    let URL_NEW_ITEM = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/update_ItemtblItems.php"
    let URL_SELECT_USER = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/select_seller.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSaveOutlet.isHidden = true
        txtNewName.text! = newName
        txtNewPrice.text! = newPrice
        txtNewQty.text! = newQty
        txtNewDesc.text! = newDesc
        txtNewDesc.isEditable = false
        newQtyStepper.isEnabled = false
        print (id)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: "dismissKeyboard")
        self.hideKeyboardWhenTappedAround()
        
        view.addGestureRecognizer(tap)
       
        
        
    }
    
    @IBAction func btnDeleteItem(_ sender: Any) {
    }
    
    @IBAction func btnUpdateItem(_ sender: Any) {
        txtNewName.isEnabled = true
        txtNewPrice.isEnabled = true
        btnSaveOutlet.isHidden = false
        txtNewDesc.isEditable = true
        btnEditOutlet.isHidden = true
        newQtyStepper.isEnabled = true
    }
    
    @IBAction func btnSaveUpdatedItem(_ sender: Any) {

        txtNewName.isEnabled = false
        txtNewPrice.isEnabled = false
        txtNewDesc.isEditable = false
        btnEditOutlet.isHidden = false
        btnSaveOutlet.isHidden = true
        newQtyStepper.isEnabled = false
       
        print (newDesc)
        print (newQty)
        print (newPrice)
        print (newName)
        
        let parameters:Parameters =  ["id":id, "item_name":txtNewName.text!, "price":txtNewPrice.text!, "quantity":txtNewQty.text!, "description":txtNewDesc.text!];
        Alamofire.request( URL_NEW_ITEM, method:.post, parameters: parameters).responseString{
            response in
            print(response)
            
            let alert = UIAlertController (title: "Item updated", message: message, preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
                UIAlertAction in NSLog ("OK Pressed")
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction (okAction)
            self.present(alert, animated: true, completion:nil)
            
            if let result=response.result.value{
                //converting it as NSDictionary
                
                
                if message != "ii"{
                    print("yay")
                }
                else {
                    let alert = UIAlertController (title: "Item update", message: message, preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
                        UIAlertAction in NSLog ("OK Pressed")
                        self.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction (okAction)
                    self.present(alert, animated: true, completion:nil)
                }
            }
            
        }

        
    }
    
    
    
}
