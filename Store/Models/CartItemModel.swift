//
//  CartItem.swift
//  Store
//
//  Created by Apple on 9/13/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import RealmSwift
class CartItemModel: Object{
    @objc dynamic var shoeName = ""
    @objc dynamic var shoePrice = 0
    @objc dynamic var shoeSize = 0
    @objc dynamic var shoeImage = ""
    @objc dynamic var shoeCount = 1
    @objc dynamic var shoeId = 0
    convenience init(shoeName: String, shoePrice: Int, shoeImage: String, shoeSize: Int,shoeCount: Int, shoeId: Int){
        self.init()
        self.shoeName = shoeName
        self.shoePrice = shoePrice
        self.shoeImage = shoeImage
        self.shoeSize = shoeSize
        self.shoeCount = shoeCount
        self.shoeId = shoeId

    }
//    override static func primaryKey() -> String? {
//        return "shoeId"
//    }
}
