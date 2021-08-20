//
//  FirstViewController.swift
//  The Green Merchant
//
//  Created by Paul Austria on 01/03/2019.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire

var itemsPrice: [String] = []
var itemsArray: [String] = []
var itemsQuantity: [String] = []
var itemsDescription: [String] = []
var itemsSellerName: [String] = []
var itemsSellerAddress: [String] = []
var itemsSellerContact: [String] = []
var itemsSellerEmail: [String] = []
var itemID:[String] = []
var orderCount:[String] = []
var orderSellerUname:[String] = []
class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  //justine
    
    @IBOutlet weak var itemsTableView: UITableView!
    let URL_USER_RETRIEVE = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/select_all_items.php";
    
    var savingSellerUsername = ""
    var cellRetrievedName = ""
    var cellRetrievedPrice = ""
    var cellRetrievedQuantity = ""
    var cellRetrievedDescription = ""
    var cellRetrievedSellerName = ""
    var cellRetrievedSellerAddr = ""
    var cellRetrievedSellerContact = ""
    var cellRetrievedSellerEmail = ""
    var cellRetrievedId = ""
    var cellRetrievedOrder = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        itemID.removeAll()
        itemsArray.removeAll()
        itemsPrice.removeAll()
        itemsQuantity.removeAll()
        itemsDescription.removeAll()
        itemsSellerName.removeAll()
        itemsSellerAddress.removeAll()
        itemsSellerContact.removeAll()
        itemsSellerEmail.removeAll()
        Alamofire.request(URL_USER_RETRIEVE, method: .get).responseJSON { response in
            print(response)
            if let getResult = response.result.value as? [Dictionary<String,AnyObject>]{
                //let jsonRetrieved = getResult as! NSArray
                for eachDict in getResult{
                    print(eachDict)
                    let resDict = eachDict as NSDictionary
                    let itemName = resDict.value(forKey: "item_name") as! String?
                    let itemPrice = resDict.value(forKey: "price") as! String?
                    let itemQty = resDict.value(forKey: "quantity") as! String?
                    let itemDesc = resDict.value(forKey: "description") as! String?
                    let itemSeller = resDict.value(forKey: "seller_name") as! String?
                    let itemAddr = resDict.value(forKey: "seller_address") as! String?
                    let itemContact = resDict.value(forKey: "seller_contact") as! String?
                    let itemEmail = resDict.value(forKey: "seller_email") as! String?
                    let susername = resDict.value(forKey: "seller_username") as! String?
                    let itemId = resDict.value(forKey: "id") as! String?
                    let itemOrder = resDict.value(forKey: "item_order") as! String?
                    
                    orderSellerUname.append(susername!)
                    orderCount.append(itemOrder!)
                    itemsArray.append(itemName!)
                    itemsPrice.append(itemPrice!)
                    itemsQuantity.append(itemQty!)
                    itemsDescription.append(itemDesc!)
                    itemsSellerName.append(itemSeller!)
                    itemsSellerAddress.append(itemAddr!)
                    itemsSellerContact.append(itemContact!)
                    itemsSellerEmail.append(itemEmail!)
                    itemID.append(itemId!)
                    self.itemsTableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ItemsTableViewCell
        cell?.itemNameHolder.text = itemsArray[indexPath.row]
        cell?.itemPriceHolder.text = "Php " +  itemsPrice[indexPath.row] + ".00"
        cell?.itemSellerName.text = itemsSellerName[indexPath.row]
        cell?.itemRemaining.text = itemsQuantity[indexPath.row]
        return cell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = itemsTableView.cellForRow(at: indexPath) as! UITableViewCell
        cellRetrievedName = itemsArray[indexPath.row]
        cellRetrievedPrice = itemsPrice[indexPath.row]
        cellRetrievedQuantity = itemsQuantity[indexPath.row]
        cellRetrievedDescription = itemsDescription[indexPath.row]
        cellRetrievedSellerName = itemsSellerName[indexPath.row]
        cellRetrievedSellerAddr = itemsSellerAddress[indexPath.row]
        cellRetrievedSellerContact = itemsSellerContact[indexPath.row]
        cellRetrievedSellerEmail = itemsSellerEmail[indexPath.row]
        cellRetrievedId = itemID[indexPath.row]
        cellRetrievedOrder = orderCount[indexPath.row]
        savingSellerUsername = orderSellerUname[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let showItemsDetails = segue.destination as! itemDetailsViewController
        showItemsDetails.passedItemName = cellRetrievedName
        showItemsDetails.passedItemPrice = cellRetrievedPrice
        showItemsDetails.passedItemQuantity = cellRetrievedQuantity
        showItemsDetails.passedItemDescription = cellRetrievedDescription
        showItemsDetails.passedItemSellerName = cellRetrievedSellerName
        showItemsDetails.passedItemSellerAdd = cellRetrievedSellerAddr
        showItemsDetails.passedItemSellerContact = cellRetrievedSellerContact
        showItemsDetails.passedItemSellerEmail = cellRetrievedSellerEmail
        showItemsDetails.passedId = cellRetrievedId
        showItemsDetails.passedOrder = cellRetrievedOrder
        showItemsDetails.passedSellerUname = savingSellerUsername
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
   
        
        
    }
//justine
  //  extension ViewController:UISearchBarDelegate{
   //     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //        search = itemsArray.filter({$0.prefix(searchText.count) == searchText})
    //        searching = true
           


