//
//  BuyerForm.swift
//  The Green Merchant
//
//  Created by CITE Student on 3/6/19.
//  Copyright © 2019 Paul Austria. All rights reserved.
//

import UIKit
import Alamofire


class BuyerForm: UIViewController, UITextFieldDelegate {
    
    var chosenCategory = ""
    var legal1 = ""
    var legal2 = ""
    var legal3 = ""
    var status = ""
    var concatenatedLegalDoc = ""
    
    let URL_NEW_BUYER = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/signup.php"
    let URL_NEW_COMM = "http://ap1902-001-site1.htempurl.com/iOS_FinalProject/process1/add_commission.php"
    
    @IBOutlet var txtMSFirstname: UITextField!
    @IBOutlet var txtMSLastname: UITextField!
    @IBOutlet var txtMSMiddlename: UITextField!
    @IBOutlet var txtMSContactNo: UITextField!
    @IBOutlet var txtMSAddress: UITextField!
    @IBOutlet var txtMSEmailAddress: UITextField!
    @IBOutlet var txtMSUsername: UITextField!
    @IBOutlet var txtMSPassword: UITextField!
    @IBOutlet var txtConfirmPassword: UITextField!
    
    
    @IBOutlet var lblLegalOutlet: UILabel!
    @IBOutlet var btnLegalDoc1Outlet: UIButton!
    @IBOutlet var btnLegalDoc2Outlet: UIButton!
    @IBOutlet var btnLegalDoc3Outlet: UIButton!
    @IBOutlet var btnBuyerCategoryOutlet: UIButton!
    @IBOutlet var btnSellerCategoryOutlet: UIButton!
    @IBOutlet var btnLDHelpOutlet: UIButton!
    @IBOutlet var BusinessPermitOutlet: UILabel!
    @IBOutlet var PoliceClearanceOutlet: UILabel!
    @IBOutlet var CedulaOutlet: UILabel!
    

    @IBAction func btnChooseBuyer(_ sender: Any) {
        if btnBuyerCategoryOutlet.isSelected{
            btnBuyerCategoryOutlet.isSelected = false
            chosenCategory = ""
            chosenCategory = ""
            lblLegalOutlet.isHidden = true
            btnLegalDoc1Outlet.isHidden = true
            btnLegalDoc2Outlet.isHidden = true
            btnLDHelpOutlet.isHidden = true
            BusinessPermitOutlet.isHidden = true
            PoliceClearanceOutlet.isHidden = true
            print(chosenCategory)
        } else {
            btnSellerCategoryOutlet.isSelected = false
            btnBuyerCategoryOutlet.isSelected = true
            chosenCategory = "BUYER"
            lblLegalOutlet.isHidden = false
            btnLegalDoc1Outlet.isHidden = false
            btnLegalDoc2Outlet.isHidden = false
            btnLegalDoc3Outlet.isHidden = true
            btnLDHelpOutlet.isHidden = false
            BusinessPermitOutlet.isHidden = false
            PoliceClearanceOutlet.isHidden = false
            CedulaOutlet.isHidden = true
            btnLegalDoc3Outlet.isSelected = false
            legal1 = ""
            print(chosenCategory)
            print(legal1)
        }
    }
    
    @IBAction func btnChooseSeller(_ sender: Any) {
        if btnSellerCategoryOutlet.isSelected{
            btnSellerCategoryOutlet.isSelected = false
            lblLegalOutlet.isHidden = false
            lblLegalOutlet.isHidden = true
            btnLegalDoc3Outlet.isHidden = true
            btnLDHelpOutlet.isHidden = true
            CedulaOutlet.isHidden = true
        } else {
            
            btnSellerCategoryOutlet.isSelected = true
            btnBuyerCategoryOutlet.isSelected = false
            chosenCategory = "SELLER"
            lblLegalOutlet.isHidden = false
            btnLegalDoc1Outlet.isHidden = true
            btnLegalDoc2Outlet.isHidden = true
            btnLegalDoc3Outlet.isHidden = false
            btnLDHelpOutlet.isHidden = false
            BusinessPermitOutlet.isHidden = true
            PoliceClearanceOutlet.isHidden = true
            CedulaOutlet.isHidden = false
            btnLegalDoc1Outlet.isSelected = false
            btnLegalDoc2Outlet.isSelected = false
            legal1 = ""
            legal2 = ""
            print(chosenCategory)
            print(legal1)
            print(legal2)
        }
    }
    
    
    
    @IBAction func btnLDHelp(_ sender: Any) {
        let mbox = UIAlertController(title: "Why do I need these?", message:"You need to present the checked files to our office in order to activate your account.", preferredStyle: UIAlertController.Style.alert)
        mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil))
        self.present(mbox,animated: true, completion: nil)
    }
    
    @IBAction func btn_cancel(_ sender: Any) {

            let controller:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoggedOutVC") as UIViewController
            self.present(controller, animated: true, completion: nil)

    }
    
    @IBAction func btnLegalDoc1(_ sender: Any) {
        if btnLegalDoc1Outlet.isSelected {
            btnLegalDoc1Outlet.isSelected = false
            legal1 = ""
        } else {
            btnLegalDoc1Outlet.isSelected = true
            legal1 = "Bureau of Internal Revenue"
            print(legal1)
        }
    }
    @IBAction func btnLegalDoc2(_ sender: Any) {
        if btnLegalDoc2Outlet.isSelected {
            btnLegalDoc2Outlet.isSelected = false
            legal2 = ""
        } else {
            btnLegalDoc2Outlet.isSelected = true
            legal2 = "Police Clearance"
            print(legal2)
        }
    }
    
    @IBAction func btnLegalDoc3(_ sender: Any) {
        if btnLegalDoc3Outlet.isSelected {
            btnLegalDoc3Outlet.isSelected = false
            legal3 = ""
        } else {
            btnLegalDoc3Outlet.isSelected = true
            legal3 = "Community Tax Certificate (Cedula)"
            print(legal1)
        }
    }
    
    
    @IBAction func btnMSSignUp(_ sender: Any) {
        concatenatedLegalDoc = legal1 + " " + legal2 + "" + legal3
        let params: Parameters = ["user_lastname":txtMSLastname.text!,"user_firstname":txtMSFirstname.text!, "user_middlename":txtMSMiddlename.text!, "username":txtMSUsername.text!, "password":txtMSPassword.text!,"address":txtMSAddress.text!,"contact_num":txtMSContactNo.text!,"email_add":txtMSEmailAddress.text!, "status":"NULL", "legaldoc_1":concatenatedLegalDoc, "user_category":chosenCategory]
            if ((self.legal1 == "") && (self.legal2 == "") && (self.concatenatedLegalDoc == " ")){
                let mbox = UIAlertController(title: "Hang on!", message:"Please check the documents that you need to present in order to activate your account.", preferredStyle: UIAlertController.Style.alert)
                mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil))
                self.present(mbox,animated: true, completion: nil)
            } else if ((txtMSPassword.text!) != (txtConfirmPassword.text!)) {
                let mbox = UIAlertController(title: "Hang on!", message:"Passwords do not match", preferredStyle: UIAlertController.Style.alert)
                mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil))
                self.present(mbox,animated: true, completion: nil)
            }
            else {
                newComm()
                Alamofire.request(URL_NEW_BUYER, method:.post, parameters: params).responseJSON {
                    response in
                    print(response)
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    print(jsonData)
                    let message = jsonData.value(forKey: "message") as? String
                    if message != "Sign Up Success!" {
                        let mbox = UIAlertController(title: message, message:"", preferredStyle: UIAlertController.Style.alert)
                        mbox.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil))
                        self.present(mbox,animated: true, completion: nil)
                    } else {
                        let success = UIAlertController(title: message, message:"You can now go to our office with your legal documents in order to activate your account", preferredStyle: UIAlertController.Style.alert)
                        success.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) -> Void in
                            let controller:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoggedOutVC") as UIViewController
                            self.present(controller, animated: true, completion: nil)
                        }))
                        self.present(success,animated: true, completion: nil)
                    }
                    
                }
            }
            
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        lblLegalOutlet.isHidden = true
        btnLegalDoc1Outlet.isHidden = true
        btnLegalDoc2Outlet.isHidden = true
        btnLegalDoc3Outlet.isHidden = true
        btnLDHelpOutlet.isHidden = true
        BusinessPermitOutlet.isHidden = true
        PoliceClearanceOutlet.isHidden = true
        CedulaOutlet.isHidden = true
        self.txtMSContactNo.delegate = self
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        
        view.addGestureRecognizer(tap)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For numers
        if textField == txtMSContactNo {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    func newComm() {
        if chosenCategory == "SELLER" {
            let name = txtMSFirstname.text! + " " + txtMSMiddlename.text! + ". " + txtMSLastname.text!
            let param:Parameters = ["sellername":name, "username":txtMSUsername.text!, "totalamount":"0", "tobecollected":"0"]
            Alamofire.request(URL_NEW_COMM, method:.post, parameters: param).responseJSON {
                response in
                print(response)
            }
        }
    }
        
    
    

   
}
