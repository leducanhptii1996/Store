//
//  ItemInCartTableViewCell.swift
//  Store
//
//  Created by Apple on 9/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Nuke

class ItemInCartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mStepView: UIView!
    
    @IBOutlet weak var mNumberLabel: UILabel!
    @IBOutlet weak var mPriceShoeInCartLbl: UILabel!
    
    @IBOutlet weak var mSizeShoeInCartLbl: UILabel!
    @IBOutlet weak var mNameShoeInCartLbl: UILabel!
    @IBOutlet weak var mImageShoeInCartLbl: UIImageView!
    var shoe: Shoe!
    let realm = RealmService.shared.realm
    var onCount: ((_ cartItemModel: CartItemModel) -> Void)?
    var onSubtract: ((_ cartItemModel: CartItemModel) -> Void)?
    var data = CartItemModel()
    
    
    

    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        mStepView.onGiam = { number in
//            print("number = \(number)")
//        }
        
//        mStepView.onTang = { number in
//            print("number = \(number)")
//        }
    }
    @IBAction func onSubtractBtnTouch(_ sender: Any) {
        onSubtract!(data)
        mNumberLabel.text = String(data.shoeCount)
        
    }
   
        
    

    @IBAction func onAddBtnTouch(_ sender: Any) {
        onCount!(data)
        mNumberLabel.text = String(data.shoeCount)
  
        
    }
    
    @IBAction func onRemoveBtnTouch(_ sender: Any) {
    }
    func setCartData(data: CartItemModel){
        mNameShoeInCartLbl.text = data.shoeName
        mPriceShoeInCartLbl.text = data.shoePrice.formattedWithSeparator
        mSizeShoeInCartLbl.text = String(data.shoeSize)
        mNumberLabel.text = String(data.shoeCount)
        var url: String?
        url = data.shoeImage
        if url != ""{
            let request = ImageRequest(urlRequest: URLRequest(url: URL(string: url!)!))
            Nuke.loadImage(with: request, into: mImageShoeInCartLbl)
        }
      
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
