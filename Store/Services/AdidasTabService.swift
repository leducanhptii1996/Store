//
//  AdidasTabService.swift
//  Store
//
//  Created by Apple on 9/4/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import  FirebaseDatabase
import Firebase
class AdidasTabService{
    static func getShoeData(completion: @escaping ([Shoe]?)-> Void){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("adidas").observeSingleEvent(of: .value) { (snapshot) in
            DispatchQueue.global().async {
                if let data = snapshot.value as? [[String:AnyObject]] {
                  
                    print(data)
                    var arrShoe = [Shoe]()
                    
                    for item in data{
                    let shoeData = Shoe(shoeDictionary: item)
                        arrShoe.append(shoeData)
                    }
                    completion(arrShoe)

                    
                    
                }
            }
        
        }

    }
//    static func getAlbumImageData(completion: @escaping ([AlbumImage]?)-> Void){
//        var ref: DatabaseReference!
//        ref.child("adidas").child("album_image").observeSingleEvent(of: .value) { (snapshot) in
//            if let albumImageData = snapshot.value as? [[String:AnyObject]]{
//                var arrImage = [AlbumImage]()
//                for item in albumImageData{
//                    let imageData = AlbumImage(albumImageDictionary: item as! [String:AnyObject])
//                    arrImage.append(imageData)
//                    completion(arrImage)
//                }
//                
//            }
//        }
//        
//    }
}

