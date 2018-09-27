//
//  NikeTabService.swift
//  Store
//
//  Created by Apple on 9/19/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import  FirebaseDatabase
import Firebase
class JordanTabService{
    static func getShoeData(completion: @escaping ([Shoe]?)-> Void){
        DispatchQueue.global().async {
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("jordan").observeSingleEvent(of: .value) { (snapshot) in
                if let data = snapshot.value as? [[String:AnyObject]] {
                    print(data)
                    var arrShoe = [Shoe]()
                    
                    for item in data {
                        let shoeData = Shoe(shoeDictionary: item )
                        arrShoe.append(shoeData)
                        //                    print(arrShoe)
                    }
                    completion(arrShoe)

                    
                    
                }
            }
        
    }
}
}
