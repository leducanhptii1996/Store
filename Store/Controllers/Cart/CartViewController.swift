//
//  CartViewController.swift
//  Store
//
//  Created by Apple on 9/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import RealmSwift


class CartViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var mTableViewCart: UITableView!
//    var realm : Realm!
//    var cartItemResult: Results<CartItemModel>{
//        get{
//            return realm.objects(CartItemModel.self)
//        }
//    }
//    var cartItemModels: Results<CartItemModel>!
    
    var shoe: Shoe!
    var arrCart = [Shoe]()
    let realm = RealmService.shared.realm

  

    @IBOutlet weak var mTotalPriceLabel: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mTableViewCart.register(UINib(nibName: "ItemInCartTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemInCartTableViewCell")
        self.navigationController?.isNavigationBarHidden = false
//        let realm = RealmService.shared.realm
//        cartItemModels = realm.objects(CartItemModel.self)
        
        self.totalPrice()
        print("\(cartItemModels.count)" +  "cartItem ")
        
        mTableViewCart.reloadData()

        // Do any additional setup after loading the view.
    }

    //add item to realm
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenHeight/4
    }
//    func CountShoe(shoeCount: Int,countClosure: (Int) -> Int){
//        countClosure(shoeCount)
//    }
    
    
//    func reloadTable() {
//        mTableViewCart.reloadData()
//    }
    
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        let cartItemModelAtIndex = cartItemModels[indexPath.row]
        RealmService.shared.delete(cartItemModelAtIndex)
        self.totalPrice()
        mTableViewCart.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItemModels.count
    }
    func totalPrice()-> Int{
        
        var price: Int = 0
        if cartItemModels.count == 0{
            mTotalPriceLabel.text = price.formattedWithSeparator
            
        }
        else{
            for item in cartItemModels{
                price = price + (item.shoeCount * item.shoePrice)

            
                mTotalPriceLabel.text = price.formattedWithSeparator
            }
            
           
        }
        return price
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "CheckOutViewController" ){
            if let checkOutVC = segue.destination as? CheckOutViewController{
                checkOutVC.mPrice = self.mTotalPriceLabel.text!
                
            }
        }
    }
 
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableViewCart.dequeueReusableCell(withIdentifier: "ItemInCartTableViewCell") as! ItemInCartTableViewCell
        let cartItemModelAtIndex = cartItemModels[indexPath.row]

        
        //+
        cell.onCount = { (data) in
            try! self.realm.write {
                cartItemModelAtIndex.shoeCount = cartItemModelAtIndex.shoeCount + 1
            }
            self.totalPrice()

            print(cartItemModelAtIndex.shoeCount)
            if (cartItemModelAtIndex.shoeCount > 100){
                try! self.realm.write {
                    cartItemModelAtIndex.shoeCount = 100

                }

                data.shoeCount = cartItemModelAtIndex.shoeCount

            }
            else{
                
                data.shoeCount = cartItemModelAtIndex.shoeCount
                

            }

        
            
        
            
        }
        //-
        cell.onSubtract = {(data) in
            if(cartItemModelAtIndex.shoeCount > 1){
                try! self.realm.write {
                    cartItemModelAtIndex.shoeCount = cartItemModelAtIndex.shoeCount - 1
                }
            }
            self.totalPrice()

            
            print(cartItemModelAtIndex.shoeCount)
            if (cartItemModelAtIndex.shoeCount < 1){
                cartItemModelAtIndex.shoeCount = 1
                data.shoeCount = cartItemModelAtIndex.shoeCount
                
            }
                
            else{
                data.shoeCount = cartItemModelAtIndex.shoeCount
            }
            
            
        }
        

        cell.shoe = self.shoe
        cell.setCartData(data: cartItemModelAtIndex)
        
        
        
        
        cell.selectionStyle = .none
        return cell
        
        
    }

}
