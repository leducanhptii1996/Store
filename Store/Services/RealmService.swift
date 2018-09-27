//
//  RealmService.swift
//  Store
//
//  Created by Apple on 9/13/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import RealmSwift
class RealmService{
     init(){}
    static let shared = RealmService()
    var realm = try! Realm()
    func create<T: Object>(_ object :T){
        do{
            try realm.write{
                realm.add(object)
            }
        }
            catch{
                post(error)
            }
        
        
        
    }
    func delete<T: Object>(_ object: T){
        do{
            try realm.write{
                realm.delete(object)
            }
        }
        catch{
            post(error)
        }
    }
//    func update<T: Object>(_ object:T, with dictionary: [String: Any?]){
//        do{
//            try realm.write {
//               
//            }
//        }
//            catch{
//                post(error)
//                
//            }
//        
//    }
    func post(_ error: Error){
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"), object: error)
    }
    func observeRealmErrors(in vc: UIViewController, completion: @escaping (Error?) -> Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name("RealmError"), object: nil, queue: nil) { (notification) in
            completion(notification.object as? Error)
        }
        
    }
    func stopObservingErrors(in vc: UIViewController){
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"), object: nil)
    }
    
}
