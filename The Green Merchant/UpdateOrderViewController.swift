//
//  UpdateOrderViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 25/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire

class UpdateOrderViewController: UIViewController {
    
    
    let URL_UPDATE_ORDER = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/update_tblorders_item.php";
    let URL_SELECT_PRICE="http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/selectItemPrice.php";
    
    var max:[String] = []
    
    @IBOutlet var update_itemname: UITextField!
    @IBOutlet var update_total: UITextField!
    @IBOutlet var update_quantity: UITextField!
    @IBOutlet var stepper_update: UIStepper!
    @IBOutlet weak var btncancelout: UIButton!
    
    var passedSeller = ""
    var passedItemName = ""
    var passedItemPrice = ""
    var passedItemQuantity = ""
 
     var nid = orderId
    
    var thisPrice = ""
    var totalPrice = ""
    var orderQty:Double = 0
    var truePrice = ""
    var changingQty:Int = 0
    var conf = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        update_itemname.text! = passedItemName
        update_total.text! = passedItemPrice
        update_quantity.text! = passedItemQuantity
        stepper_update.value = Double(passedItemQuantity)!
        totoongPresyo()
        pprice()
        print("hahaha1" , passedItemName)
        print("qweqweq",passedSeller)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: "dismissKeyboard")
        self.hideKeyboardWhenTappedAround()
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    func totoongPresyo() {
        let qty = Int(update_quantity.text!)!/50
        truePrice = String(Int(update_total.text!)!/qty)
    }
    
    @IBAction func btn_Update(_ sender: Any) {
        if (conf == "ACCEPTED"){
            let mbox = UIAlertController(title: "NOTICE", message:"This item has already been accepted by the seller. You can no longer alter, modify, or cancel your order.", preferredStyle: UIAlertController.Style.alert)
            mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil))
            self.present(mbox,animated: true, completion: nil)
        } else {
        let parameters:Parameters =  ["id":id, "order_quantity":update_quantity.text!, "order_total":totalPrice];
        Alamofire.request( URL_UPDATE_ORDER, method:.post, parameters: parameters).responseString{
                response in
                print(response)
            
            let alert = UIAlertController (title: "Item update", message: message, preferredStyle: UIAlertController.Style.alert)
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
    
    
    
    
    @IBAction func stepper(_ sender: UIStepper) {
        //update_total.text! = String(Int(sender.value))
        update_quantity.text! = String(Int(sender.value))
        changingQty = Int(sender.value)
        orderQty = Double(update_quantity.text!)!/50
        totalPrice = String(orderQty * Double(truePrice)!)
        update_total.text = "Php " + String(totalPrice) + "0"
        

    }
    
    func pprice() {
        let parameters:Parameters = ["item_name":passedItemName]
        Alamofire.request(URL_SELECT_PRICE, method:.post, parameters: parameters).responseJSON{
            response in
            print(response)
            if let getResult = response.result.value as? [Dictionary<String,AnyObject>]{
                for eachDict in getResult{
                    print(eachDict)
                    let resDict = eachDict as NSDictionary
                    let originalQty = resDict.value(forKey: "quantity") as! String?
                    self.thisPrice = originalQty!
                    print(self.thisPrice)
                }
            }
        }
    }
    
    
    
    

}


