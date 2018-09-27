//
//  TabAdidasViewController.swift
//  Store
//
//  Created by Apple on 9/4/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import RealmSwift

//let screenBounds = UIScreen.main.bounds
//let screenWidth = screenBounds.width
//let screenHeight = screenBounds.height
//var cartItemModels: Results<CartItemModel>!



class TabJordanViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var mShoe =  [Shoe]()
    var selectedShoe: Shoe?
    let cellSpacing: CGFloat = 10
    let collectionCellController = "CollectionCellController"
    
    @IBOutlet weak var mCollectionJordanView: UICollectionView!
    
    
    @IBOutlet weak var mMenuButton: UIBarButtonItem!
    
    func requestData() {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicatorView.color = UIColor.red
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.frame = self.view.frame
        activityIndicatorView.center = self.view.center
        activityIndicatorView.startAnimating()
        JordanTabService.getShoeData { (arrShoe) in
            
            DispatchQueue.main.async {

                self.mShoe = arrShoe!
                activityIndicatorView.stopAnimating()

                
                self.mCollectionJordanView.reloadData()
            }
        }
        
    }
    
    @IBAction func mCartButtonTouched(_ sender: Any) {
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        let detailScene = sb.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(detailScene, animated: true)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        //request data
        tabBarController?.tabBar.isHidden = false
        
        
    }
    //    //add item to realm
    //    func addItemToRealm(){
    //        //add item to realm
    //        let newCartItem = CartItemModel()
    //        RealmService.shared.create(newCartItem)
    //
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil{
            mMenuButton.target = revealViewController()
            mMenuButton.action = "revealToggle:"
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        requestData()

        
        //register xib
        mCollectionJordanView.register(UINib(nibName: "CollectionCellController", bundle: nil), forCellWithReuseIdentifier: collectionCellController)
        self.navigationItem.title = " "
        //realm
        let realm = RealmService.shared.realm
        cartItemModels = realm.objects(CartItemModel.self)
        
        
        
        //        addItemToRealm()
        
        
        
        //set khoảng trống của cell
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mShoe.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (screenWidth - 3*cellSpacing)/2 , height: screenWidth/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellController",for: indexPath) as! CollectionCellController
        
        cell.setPlaceHolder()
        
        //set data
        cell.setData(data: mShoe[indexPath.row])
        
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        let detailScene = sb.instantiateViewController(withIdentifier: "DetailShoeTableViewController") as! DetailShoeTableViewController
        //         let cartScene = sb.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        selectedShoe = self.mShoe[indexPath.row]
        detailScene.shoe = selectedShoe
        
        detailScene.navigationItem.title = "Chi tiết"
        
        
        
        self.navigationController?.pushViewController(detailScene, animated: true)
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
