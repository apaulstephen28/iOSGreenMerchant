//
//  SecondViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 01/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire



var id = ""
class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var retrievedCartName:[String] = []
    var retrievedCartPrice:[String] = []
    var retrievedCartQty:[String] = []
    var retrievedCartDesc:[String] = []
    var retrievedCartSeller:[String] = []
    var retrievedCartAdd:[String] = []
    var retrievedCartContact:[String] = []
    var retrievedCartEmail:[String] = []
    var retrievedCartConf:[String] = []
    var id2:[String] = []
    
    
    var updated_name = ""
    var updated_price = ""
    var updated_qty = ""
    var updated_conf = ""
    var seller = ""
    var itemname = ""

    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retrievedCartName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOrders.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? cartTableViewCell
        cell?.cartItemName.text = retrievedCartName[indexPath.row]
        cell?.cartItemPrice.text = "Php " +  retrievedCartPrice[indexPath.row] + ".00"
        cell?.cartItemQty.text = retrievedCartQty[indexPath.row] + "kgs"
        cell?.cartItemSeller.text = retrievedCartSeller[indexPath.row]
        id = id2[indexPath.row]
        seller = retrievedCartSeller[indexPath.row]
        cell?.cartItemConf.text = retrievedCartConf[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        updated_name = retrievedCartName[indexPath.row]
        updated_price = retrievedCartPrice[indexPath.row]
        updated_qty = retrievedCartQty[indexPath.row]
//        id = itemID[indexPath.row]
        id = id2[indexPath.row]
        updated_conf = retrievedCartConf[indexPath.row]
        performSegue(withIdentifier: "userOrderSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    //variables
    let URL_USER_RETRIEVE="http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/select_all_in_cart.php";

    
    @IBOutlet var tableViewOrders: UITableView!
    @IBOutlet var lblRetrievedName: UILabel!
    var thisSeller = ""
    
    
    
    //didload
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        retrievedCartName.removeAll()
        retrievedCartPrice.removeAll()
        retrievedCartQty.removeAll()
        retrievedCartDesc.removeAll()
        retrievedCartSeller.removeAll()
        retrievedCartAdd.removeAll()
        retrievedCartContact.removeAll()
        retrievedCartEmail.removeAll()
        print(thisSeller)
        let parameters:Parameters = ["buyer_username":username]
        Alamofire.request(URL_USER_RETRIEVE, method: .post, parameters:parameters).responseJSON { response in
            print(response)
            if let getResult = response.result.value as? [Dictionary<String,AnyObject>]{
                //let jsonRetrieved = getResult as! NSArray
                for eachDict in getResult{
                    print(eachDict)
                    let resDict = eachDict as NSDictionary
                    let id1 = resDict.value(forKey: "id") as! String?
                    let itemName = resDict.value(forKey: "order_itemname") as! String?
                    let itemPrice = resDict.value(forKey: "order_total") as! String?
                    let itemQty = resDict.value(forKey: "order_quantity") as! String?
                    let itemDesc = resDict.value(forKey: "order_desc") as! String?
                    let itemSeller = resDict.value(forKey: "seller_firstname") as! String?
                    let itemAddr = resDict.value(forKey: "seller_address") as! String?
                    let itemContact = resDict.value(forKey: "seller_contact") as! String?
                    let itemEmail = resDict.value(forKey: "seller_email") as! String?
                    let itemSUsername = resDict.value(forKey: "seller_username") as! String?
                    let cconfirmation = resDict.value(forKey: "confirmation") as! String?
                    
                    self.thisSeller = itemSUsername!
                   self.id2.append(id1!)
                   self.retrievedCartConf.append(cconfirmation!)
                    self.retrievedCartName.append(itemName!)
                    self.retrievedCartPrice.append(itemPrice!)
                    self.retrievedCartQty.append(itemQty!)
                    self.retrievedCartDesc.append(itemDesc!)
                    self.retrievedCartSeller.append(itemSeller!)
                    self.retrievedCartAdd.append(itemAddr!)
                    self.retrievedCartContact.append(itemContact!)
                    self.retrievedCartEmail.append(itemEmail!)
                    self.tableViewOrders.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let updated_Item = segue.destination as! UpdateOrderViewController
        updated_Item.passedItemName = updated_name
        updated_Item.passedItemPrice = updated_price
        updated_Item.passedItemQuantity = updated_qty
        updated_Item.passedSeller = seller
        updated_Item.conf = updated_conf
    }
    


}
