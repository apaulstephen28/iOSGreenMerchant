//
//  SellerOrdersViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 20/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire

var orderBuyerName:[String] = []
var orderItemName:[String] = []
var orderQuantity:[String] = []
var orderTotal:[String] = []
var orderPhone:[String] = []
var orderEmail:[String] = []
var orderAddr:[String] = []
var orderId:[String] = []
var orderConfirm:[String] = []
class SellerOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var preparingId = ""
    var preparingOrderBuyer = ""
    var preparingOrderName = ""
    var preparingOrderPrice = ""
    var preparingOrderQty = ""
    var preparingOrderTotal = ""
    var preparingOrderPhone = ""
    var preparingOrderEmail = ""
    var preparingOrderAddr = ""
    var preparingOrderConf = ""
    var preparingQty:Double = 0
    var preparingTotal:Double = 0
    
    
    @IBOutlet var TableViewOrder: UITableView!
    let URL_SELECT_USER = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/select_order.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func selectAllItems() {
        let parameters:Parameters = ["seller_username":username]
        Alamofire.request(URL_SELECT_USER, method: .post, parameters:parameters).responseJSON { rows in
            print(rows)
            if let getResult = rows.result.value as? [Dictionary<String,AnyObject>]{
                //let jsonRetrieved = getResult as! NSArray
                print(getResult)
                for eachDict in getResult{
                    print(eachDict)
                    let resDict = eachDict as NSDictionary
                    let savedName = resDict.value(forKey: "order_itemname") as! String?
                    let savedQty = resDict.value(forKey: "order_quantity") as! String?
                    let savedBuyer = resDict.value(forKey: "buyer_firstname") as! String?
                    let savedTotal = resDict.value(forKey: "order_total") as! String?
                    let savedPhone = resDict.value(forKey: "seller_contact") as! String?
                    let savedEmail = resDict.value(forKey: "seller_email") as! String?
                    let savedAddr = resDict.value(forKey: "seller_address") as! String?
                    let savedId = resDict.value(forKey: "id") as! String?
                    let savedConf = resDict.value(forKey: "confirmation") as! String?
                    orderConfirm.append(savedConf!)
                    orderId.append(savedId!)
                    orderItemName.append(savedName!)
                    orderQuantity.append(savedQty!)
                    orderBuyerName.append(savedBuyer!)
                    orderTotal.append(savedTotal!)
                    orderPhone.append(savedPhone!)
                    orderEmail.append(savedEmail!)
                    orderAddr.append(savedAddr!)
                    self.TableViewOrder.reloadData()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        orderItemName.removeAll()
        orderBuyerName.removeAll()
        orderQuantity.removeAll()
        orderTotal.removeAll()
        orderPhone.removeAll()
        orderEmail.removeAll()
        orderAddr.removeAll()
        orderConfirm.removeAll()
        orderId.removeAll()
        selectAllItems()
        TableViewOrder.reloadData()
        print(orderId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderBuyerName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewOrder.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? OrderTableViewCell
        cell?.orderNameStorage.text! = orderBuyerName[indexPath.row]
        cell?.orderItemStorage.text! = orderItemName[indexPath.row]
        cell?.orderQtyStorage.text! = orderQuantity[indexPath.row] + " kgs"
        cell?.orderTotalStorage.text! = "Php " + orderTotal[indexPath.row] + ".00"
        cell?.orderActionStorage.text! = orderConfirm[indexPath.row]
        cell?.orderIdStorage.text! = orderId[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        preparingOrderBuyer = orderBuyerName[indexPath.row]
        preparingOrderName = orderItemName[indexPath.row]
        preparingOrderQty = orderQuantity[indexPath.row]
        preparingOrderTotal = orderTotal[indexPath.row]
        preparingOrderPhone = orderPhone[indexPath.row]
        preparingOrderEmail = orderEmail[indexPath.row]
        preparingOrderAddr = orderAddr[indexPath.row]
        preparingId = orderId[indexPath.row]
        preparingOrderConf = orderConfirm[indexPath.row]
        performSegue(withIdentifier: "toConfirmOrderSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let acceptOrderVC = segue.destination as! OrderConfirmViewController
        acceptOrderVC.id = preparingId
        acceptOrderVC.acceptOrderBuyer = preparingOrderBuyer
        acceptOrderVC.acceptOrderName = preparingOrderName
        acceptOrderVC.acceptOrderQty = preparingOrderQty
        acceptOrderVC.acceptOrderTotal = preparingOrderTotal
        acceptOrderVC.acceptOrderPhone = preparingOrderPhone
        acceptOrderVC.acceptOrderAddr = preparingOrderAddr
        acceptOrderVC.acceptOrderEmail = preparingOrderEmail
        acceptOrderVC.testConf = preparingOrderConf
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }

}
