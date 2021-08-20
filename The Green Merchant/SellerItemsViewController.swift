//
//  SellerItemsViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 16/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire

var sellingNameStorage:[String] = []
var sellingPriceStorage:[String] = []
var sellingQtyStorage:[String] = []
var sellingOrderStorage:[String] = []
var sellingIDStorage:[String] = []
var sellingDescStorage:[String] = []
class SellerItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var id = ""
    var preparedName = ""
    var preparedPrice = ""
    var preparedQty = ""
    var preparedDesc = ""
    var thisName = username
    
    let URL_SELECT_USER = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/select_seller.php"

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sellingNameStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSellingItems.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SellerItemsTableViewCell
        cell?.SlblItemName.text! = sellingNameStorage[indexPath.row]
        cell?.SlblItemPrice.text! = sellingPriceStorage[indexPath.row]
        cell?.SlblItemQty.text! = sellingQtyStorage[indexPath.row]
        cell?.SlblItemOrder.text! = sellingOrderStorage[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        preparedName = sellingNameStorage[indexPath.row]
        preparedPrice = sellingPriceStorage[indexPath.row]
        preparedQty = sellingQtyStorage[indexPath.row]
        preparedDesc = sellingDescStorage[indexPath.row]
         id = sellingIDStorage[indexPath.row]
        performSegue(withIdentifier: "updateItemSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let updateVC = segue.destination as! UpdateItemViewController
        updateVC.id = id
        updateVC.newName = preparedName
        updateVC.newPrice = preparedPrice
        updateVC.newQty = preparedQty
        updateVC.newDesc = preparedDesc
    }
    

    @IBAction func btnAddItem(_ sender: UIButton) {
        let controller:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newItemID") as UIViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBOutlet var tblSellingItems: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sellingNameStorage.removeAll()
        sellingPriceStorage.removeAll()
        sellingQtyStorage.removeAll()
        sellingOrderStorage.removeAll()
        sellingIDStorage.removeAll()
        let parameters:Parameters = ["seller_username":thisName]
        Alamofire.request(URL_SELECT_USER, method: .post, parameters:parameters).responseJSON { rows in
            print(rows)
            if let getResult = rows.result.value as? [Dictionary<String,AnyObject>]{
                //let jsonRetrieved = getResult as! NSArray
                print(getResult)
                for eachDict in getResult{
                    print(eachDict)
                    let resDict = eachDict as NSDictionary
                    let savedName = resDict.value(forKey: "item_name") as! String?
                    let savedPrice = resDict.value(forKey: "price") as! String?
                    let savedQty = resDict.value(forKey: "quantity") as! String?
                    let savedOrder = resDict.value(forKey: "item_order") as! String?
                    let savedId = resDict.value(forKey: "id") as! String?
                    let savedDesc = resDict.value(forKey: "description") as! String?
                    self.id = savedId!
                    //itemsArray.append(itemName!)
                    sellingIDStorage.append(savedId!)
                    sellingNameStorage.append(savedName!)
                    sellingPriceStorage.append(savedPrice!)
                    sellingQtyStorage.append(savedQty!)
                    sellingOrderStorage.append(savedOrder!)
                    sellingDescStorage.append(savedDesc!)
                    self.tblSellingItems.reloadData()
                }
            }
        }
    }
    


}
