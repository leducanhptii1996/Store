//
//  CheckOutViewController.swift
//  Store
//
//  Created by Apple on 9/18/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import Firebase
import FirebaseDatabase


class CheckOutViewController: UIViewController {
    
    @IBOutlet weak var mNameWarning: UILabel!
    
    @IBOutlet weak var mAddressWarning: UILabel!
    
    @IBOutlet weak var mPhoneWarning: UILabel!
    @IBOutlet weak var mFullNameTextField: UITextField!
    @IBOutlet weak var mAddressTextField: UITextField!
     @IBOutlet weak var mPhoneNumTextField: UITextField!
    var mPrice: String = ""
    let realm = RealmService.shared.realm

    struct StoryBoard{
        static let CheckOutViewController = "CheckOutViewController"
        static let SuccessfulCheckOutViewController = "SuccessfulCheckOutViewController"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)


        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func validatePhone(phoneNum: UITextField,phoneWarning: UILabel) -> Bool{
        var isNil: Bool = false
        if phoneNum.text == ""{
            phoneWarning.alpha = 1.0
            isNil = true
            return false
        }
        else {
            phoneWarning.alpha = 0
            isNil = false
            
        }
        if isNil == false{
            let predicate = NSPredicate(format: "SELF MATCHES %@", "(09|01[2|6|8|9])+([0-9]{8})")

            if predicate.evaluate(with: phoneNum.text) == false{
                let alertController = UIAlertController(title: "Có lỗi xảy ra", message:
                    "Số điện thoại nhập không đúng định dạng!", preferredStyle: UIAlertControllerStyle.alert)
                let btnRetry : UIAlertAction = UIAlertAction(title: "Thử lại", style: .default, handler: nil)
                alertController.addAction(btnRetry)
                self.present(alertController, animated: true, completion: nil)
                }

        }
        return true
    }
    func validateName(name: UITextField,nameWarning: UILabel) -> Bool{
        if(name.text == ""){
            nameWarning.alpha = 1.0
            return false
        }
        else {
            nameWarning.alpha = 0
            return true
            
        }
    }
    func validateAddress(address: UITextField,addressWarning: UILabel) -> Bool{
        if(address.text == ""){
            addressWarning.alpha = 1.0
            return false
        }
        else {
            addressWarning.alpha = 0
            return true

        }
        
        
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == StoryBoard.SuccessfulCheckOutViewController{
//
//            if let successfulCheckOutVC = segue.destination as? SuccessfulCheckOutViewController{
//                
//            }
//        }
//
//    }

   
    
    @IBAction func onPurchaseTouch(_ sender: Any) {
        //validate phonenum
        var isNil: Bool =  false
        if (validateName(name: mFullNameTextField, nameWarning: mNameWarning) == false ||
            validatePhone(phoneNum: mPhoneNumTextField, phoneWarning: mPhoneWarning) == false ||
            validateAddress(address: mAddressTextField, addressWarning: mAddressWarning) == false){
//            validateName(name: mFullNameTextField, nameWarning: mNameWarning)
            validatePhone(phoneNum: mPhoneNumTextField, phoneWarning: mPhoneWarning)
            validateAddress(address: mAddressTextField, addressWarning: mAddressWarning)
            let alertController = UIAlertController(title: "Có lỗi xảy ra", message:
                "Bạn nhập thiếu thông tin!", preferredStyle: UIAlertControllerStyle.alert)
            let btnRetry : UIAlertAction = UIAlertAction(title: "Quay lại", style: .default, handler: nil)
            alertController.addAction(btnRetry)
            isNil = true
            self.present(alertController, animated: true, completion: nil)
        }
        if isNil == false{
            validatePhone(phoneNum: mPhoneNumTextField,phoneWarning: mPhoneWarning)

        }
//        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
//        activityIndicatorView.color = UIColor.red
//        self.view.addSubview(activityIndicatorView)
//        activityIndicatorView.frame = self.view.frame
//        activityIndicatorView.center = self.view.center
//        activityIndicatorView.startAnimating()
       
        pushDataToFireBase {
//                activityIndicatorView.stopAnimating()
                let sb = UIStoryboard(name: "CheckOut", bundle: nil)
            
                let successfulCheckOutVC = sb.instantiateViewController(withIdentifier: StoryBoard.SuccessfulCheckOutViewController) as! SuccessfulCheckOutViewController
                successfulCheckOutVC.mName = self.mFullNameTextField.text
                successfulCheckOutVC.mPhoneNum = self.mPhoneNumTextField.text
                successfulCheckOutVC.mTotalPrice = self.mPrice
                successfulCheckOutVC.mAddress = self.mAddressTextField.text
            try! self.realm.write {
                self.realm.deleteAll()
                }
                //push data to firebase
                
                
                self.navigationController?.pushViewController(successfulCheckOutVC, animated: true)
                print("PUSK OK")
            
            
        }

        


        
    }
    func pushDataToFireBase(completion: @escaping () -> Void){
            var ref : DatabaseReference!
            ref = Database.database().reference()
            
            let keyOrder = ref.child("orders").childByAutoId().key
            let date = Date()
            let dateFormater = DateFormatter()
            let hourFormater = DateFormatter()

            dateFormater.dateFormat = "yyyy/MM/dd"
                hourFormater.dateFormat = "HH:mm"
            let someDateTime = dateFormater.string(from: date)
            let someHour = hourFormater.string(from: date)

//            let stringDate = "\(someDateTime)"

            let name = self.mFullNameTextField.text
            let address = self.mAddressTextField.text
            let phone = self.mPhoneNumTextField.text
            
            
        let order =
                        [
                        "address": address,
                         "customer_name": name,
                         "phonenum": phone,
                         "totalPrice": self.mPrice,
                         "date": someDateTime,
                         "time": someHour,
                         "key": keyOrder,
                         "status": 0
                            
                            ] as [String : Any]
            let childUpdates = ["/orders/\(keyOrder)": order]
        
            ref.updateChildValues(childUpdates)
            //update product
            

            for item in cartItemModels{
                let keyProduct = ref.child("orders").childByAutoId().key

                let product = ["name": item.shoeName,
                               "size": item.shoeSize,
                               "count": item.shoeCount,
                               "represent_image": item.shoeImage,
                    "price": item.shoePrice
                    ] as [String : Any]
//                let refProduct = ref.child("orders").child(keyOrder).child("product").child(item.shoeName).child("Size: " + String(item.shoeSize))
                let childUpdateProduct = ["/orders/\(keyOrder)/product/\(keyProduct)": product]
                ref.updateChildValues(childUpdateProduct)
                
//                refProduct.setValue(item.shoeCount)
            }
            
        
                
                
        
       
        completion()

    }
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
