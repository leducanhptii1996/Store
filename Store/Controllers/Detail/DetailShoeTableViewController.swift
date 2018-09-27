//
//  DetailShoeTableViewController.swift
//  Store
//
//  Created by Apple on 9/5/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import DropDown
import RealmSwift

class DetailShoeTableViewController: UITableViewController{
    
    var shoe: Shoe!
    var mCart = [Shoe]()
    var cartScene: CartViewController?
    //    var cartItemResult: Results<CartItemModel>{
    //        get{
    //            return realm.objects(CartItemModel.self)
    //        }
    //    }
    var cartItemModel: CartItemModel?
    let realm = RealmService.shared.realm
    
    
    
    
    
    @IBOutlet var mDetailShoeTableView: UITableView!
    
    
    
    var mSegmentControl =  UISegmentedControl()
    @IBOutlet weak var mShoeImagesHeaderView: ShoeImagesHeaderView!
    var listSize = ["36","37","38","39","40","41","42","43"]
    struct StoryBoard{
        static let slideShowViewController = "SlideShowViewController"
        static let mShoeDetailCell = "ShoeDetailCell"
        static let mAddToCartButtonCell = "AddToCartButtonCell"
        static let cartViewController = "CartViewController"
    }
    
    
    //navigation
    struct AlbumImage{
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoard.slideShowViewController {
            if let imagesPageVC = segue.destination as? SlideShowViewController {
                imagesPageVC.shoe = self.shoe
                
                imagesPageVC.imageDetailAlbum = shoe.albumImage
                
                
                
            }
        }
        if segue.identifier == StoryBoard.cartViewController{
            if let cartVC = segue.destination as? CartViewController{
                cartVC.shoe = self.shoe

            }
            
        }
        
        
    }
    @IBAction func onSegmentValueChange(_ sender: UISegmentedControl) {
        
        
    }
    
    func addItemToRealm(){
        //add item to realm
        let newCartItem = CartItemModel(shoeName: shoe.name, shoePrice: shoe.price, shoeImage: shoe.representImage,shoeSize: shoe.size,shoeCount: shoe.shoeCount, shoeId: shoe.shoeId)
        
        RealmService.shared.create(newCartItem)
        //        mDetailShoeTableView.reloadData()
        
    }
    
   
   
    
    
    @IBAction func mAddToCartButtonTouched(_ sender: Any) {
        
        if shoe.size == 1{
            let alertController = UIAlertController(title: "Bạn chưa chọn size giày", message:
                "Vui lòng chọn size giày", preferredStyle: UIAlertControllerStyle.alert)
            let btnBack : UIAlertAction = UIAlertAction(title: "Quay lại", style: .cancel, handler: nil)
            alertController.addAction(btnBack)
            self.present(alertController, animated: true, completion: nil)
            
        }
        else if cartItemModels.count == 0 {
            self.addItemToRealm()
            
        }
        else {
            var isDuplicate: Bool = true
            for item in cartItemModels{
                print(cartItemModels.count)
                print(item)
                if(shoe.shoeId == item.shoeId && shoe.size != item.shoeSize)
                {
                    isDuplicate = false
                    print("Shoe Size:" + String(shoe.size))
                    print("item Size:" + String(item.shoeSize))
                    self.addItemToRealm()

                    break;
                    
                    
                }
              
                if(shoe.shoeId == item.shoeId && shoe.size == item.shoeSize && shoe.size != 1 &&                     isDuplicate == true){
                    print("Shoe Size:" + String(shoe.size))
                    print("item Size:" + String(item.shoeSize))
                    let realm = RealmService.shared.realm
                    do{
                        try realm.write {
                            item.shoeCount = item.shoeCount + 1
                        }
                        
                    }
                    catch{
                        print("error")

                    }
                   
                    isDuplicate = false

                    break
                    
                }
                
                
            }
//            isDuplicate = true
            if isDuplicate == true{
                for item in cartItemModels{
                    if(shoe.shoeId != item.shoeId){
//                        if isDuplicate == false{
                            self.addItemToRealm()
                            break
                            
//                        }
                        
                    }
                }
            }
            
//                isDuplicate = true
            
            
            //                if(!cartItemModels.contains(cartItemModel.s))
            
            
            
            
        }
        
        
        
        
        let alertController = UIAlertController(title: "Đã thêm vào giỏ hàng", message:
            "Bạn muốn xem giỏ hàng không?", preferredStyle: UIAlertControllerStyle.alert)
        let btnBack : UIAlertAction = UIAlertAction(title: "Quay lại", style: .cancel, handler: nil)
        
        let btnViewCart: UIAlertAction = UIAlertAction(title: "Xem giỏ hàng", style: .destructive) { (btnViewCart) -> Void in
            
            //add item to realm
            
            self.performSegue(withIdentifier: StoryBoard.cartViewController, sender: (Any).self)
            
            
            
        }
        
        alertController.addAction(btnBack)
        alertController.addAction(btnViewCart)
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    
    //    @IBAction func mCartButtonTouched(_ sender: Any) {
    ////        let sb = UIStoryboard(name: "Detail", bundle: nil)
    ////        let detailScene = sb.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
    ////        detailScene.shoe = self.shoe
    //        if(cartScene != nil){
    //            self.navigationController?.pushViewController(cartScene!, animated: true)
    //        }
    //
    //
    //    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mDetailShoeTableView.delegate = self
        mDetailShoeTableView.dataSource = self
        self.navigationController?.isNavigationBarHidden = false
        
        
        //
        tableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.mShoeDetailCell) as! DetailShoeTableViewCell
            // Configure the cell...
            cell.selectionStyle = .none
            cell.shoe = self.shoe
            
            
            cell.setDetailData(data: shoe)
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.mAddToCartButtonCell) as! AddToCartTableViewCell
            // Configure the cell...
            return cell
        }
        
        
        
    }
    
    
}
