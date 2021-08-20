//
//  OrderConfirmViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 21/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire

class OrderConfirmViewController: UIViewController {
    
    var id = ""
    var acceptOrderBuyer = ""
    var acceptOrderName = ""
    var acceptOrderPrice = ""
    var acceptOrderQty = ""
    var acceptOrderTotal = ""
    var acceptOrderPhone = ""
    var acceptOrderEmail = ""
    var acceptOrderAddr = ""
    var acceptQty:Double = 0
    var acceptTotal:Double = 0
    var testConf = ""
    var CONFIRM = "ACCEPTED"
    var mess = ""
    
    var totalAmount = ""
    var toCollect = ""
    
    let URL_ACCEPT_ORDER = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/order_accept.php"
    
    let URL_DELETE_ORDER = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/delete_ordrer.php"
    
    let URL_UPDATE_COMM = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/transaction.php"
    
    let URL_SELECT_COMM = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/select_comm.php"

    
    @IBOutlet var lblId: UILabel!
    @IBOutlet var lblAcceptBuyer: UILabel!
    @IBOutlet var lblAcceptItem: UILabel!
    @IBOutlet var lblAcceptQty: UILabel!
    @IBOutlet var lblAcceptTotal: UILabel!
    @IBOutlet var lblAcceptPhone: UILabel!
    @IBOutlet var lblAcceptEmail: UILabel!
    @IBOutlet var lblAcceptAddr: UILabel!
    @IBOutlet var outletBtnAccept: UIButton!
    @IBOutlet var outletBtnCollect: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        acceptTotal = Double(acceptOrderTotal)!
        acceptQty = Double(acceptOrderQty)!
        lblAcceptBuyer.text! = acceptOrderBuyer
        lblAcceptItem.text! = acceptOrderName
        lblAcceptQty.text! = acceptOrderQty + " kgs"
        lblAcceptTotal.text! = "Php " + acceptOrderTotal + ".00"
        lblAcceptPhone.text! = acceptOrderPhone
        lblAcceptEmail.text! = acceptOrderEmail
        lblAcceptAddr.text! = acceptOrderAddr
        lblId.text! = id
        testDBConf()
        print(id)
        selectComm()
        // Do any additional setup after loading the view.
    }
    
    func testDBConf() {
        if (testConf == "WAITING FOR CONFIRMATION") {
            outletBtnAccept.isHidden = false
            outletBtnCollect.isHidden = true
        } else {
            outletBtnAccept.isHidden = true
            outletBtnCollect.isHidden = false
        }
    }
    
    
    

    @IBAction func btnAcceptOrder(_ sender: Any) {
        print(lblId.text!)
        print(id)
        print(CONFIRM)
        let parameters:Parameters = ["id":id, "confirmation":CONFIRM]
        Alamofire.request(URL_ACCEPT_ORDER, method: .post, parameters:parameters).responseJSON { response in
            print(response)
            if let result = response.result.value {
                //converting it as NSDictionary
                print(result)
                let jsonData=result as! NSDictionary
                print(jsonData)
                let message = jsonData.value(forKey: "message") as? String
                
                
                if (message != "Accepted") {
                    //displaying the message in msgbox
                    let mbox = UIAlertController(title: "error", message:"error", preferredStyle: UIAlertController.Style.alert)
                    mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                    self.present(mbox, animated: true)
                } else {
                    self.outletBtnAccept.isHidden = true
                    self.outletBtnCollect.isHidden = false
                    let mbox = UIAlertController(title: "Success", message:"Accepted", preferredStyle: UIAlertController.Style.alert)
                    mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                    self.present(mbox, animated: true)
                }
            }
        }
    }
    
    func deleteOrder() {
        //let paraID = self.lblId.text!
        let parameters:Parameters = ["id":id]
        Alamofire.request(self.URL_DELETE_ORDER, method: .post, parameters:parameters).responseString {
            response in
            print(response)
            if let result = response.result.value {
                //converting it as NSDictionary
                print(result)
            }
        }
    }
    
    func selectComm() {
        //let paraID = self.lblId.text!
        let parameters:Parameters = ["username":username]
        Alamofire.request(self.URL_SELECT_COMM, method: .post, parameters:parameters).responseJSON {
            response in
            print(response)
            if let result = response.result.value as? [Dictionary<String,AnyObject>] {
                for dict in result {
                    print(dict)
                    let total = dict["totalamount"] as? String
                    let coll = dict["tobecollected"] as? String
                    self.totalAmount = total!
                    self.toCollect = coll!
                }
            }
        }
    }
    
    func updateComm() {
        let comm = acceptTotal * 0.10
        let totaltotal = Double(totalAmount)! + acceptTotal
        let collcoll = Double(toCollect)! + comm
        let parameters:Parameters = ["username":username, "totalamount":totaltotal, "tobecollected":collcoll]
        Alamofire.request(self.URL_UPDATE_COMM, method: .post, parameters:parameters).responseString {
            response in
            print(response)
            if let result = response.result.value {
                //converting it as NSDictionary
                print(result)
            }
        }
    }
    
    
    @IBAction func btnCollect(_ sender: Any) {
        let mbox = UIAlertController(title: "", message:"Are you sure this item has been paid?", preferredStyle: UIAlertController.Style.alert)
        
        mbox.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler: nil))
        mbox.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: {(action) -> Void in
            let mbox = UIAlertController(title: "", message:"Clicking 'OK' will delete this item.", preferredStyle: UIAlertController.Style.alert)
            mbox.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) -> Void in
                self.updateComm()
                self.deleteOrder()
                self.id = ""
                self.lblId.text = ""
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(mbox, animated: true)
        }))
        self.present(mbox, animated: true)
    }
    
}
