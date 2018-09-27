//
//  SuccessfulCheckOutViewController.swift
//  Store
//
//  Created by Apple on 9/18/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class SuccessfulCheckOutViewController: UIViewController {
    @IBOutlet weak var mNameInfoLabel: UILabel!
    
    @IBOutlet weak var mPhoneNumInfoLabel: UILabel!
    
    @IBOutlet weak var mTotalPriceInfoLabel: UILabel!
    @IBOutlet weak var mAddressInfoLabel: UILabel!

    var mName: String?
    var mPhoneNum: String?
    var mTotalPrice: String?
    var mAddress: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        mNameInfoLabel.text = mName
        mPhoneNumInfoLabel.text = mPhoneNum
        mTotalPriceInfoLabel.text = mTotalPrice
        mAddressInfoLabel.text = mAddress
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func onHomeTouchBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let homeScene = sb.instantiateViewController(withIdentifier: "TabAdidasViewController") as! TabAdidasViewController
        self.navigationController?.popToRootViewController(animated: true)
        
//         self.performSegue(withIdentifier: "TabAdidasViewController", sender: (Any).self)
        
        
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
