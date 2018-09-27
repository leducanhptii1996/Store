//
//  StepView.swift
//  Store
//
//  Created by Apple on 9/12/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class StepView : UIView {
    
    var onTang : ((Int)->Void)?
    var onGiam : ((Int)->Void)?
    var mNumber = 0
    
    @IBOutlet weak var mNumLabel: UILabel!
    @IBOutlet var mContentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        
        Bundle.main.loadNibNamed("StepView", owner: self, options: nil)
        addSubview(mContentView)
        mContentView.frame = self.bounds
        mContentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    @IBAction func onGiamToched(_ sender: Any) {
        mNumber = mNumber - 1
        if mNumber < 0 {
            mNumber = 0
        }
        
        mNumLabel.text = String(mNumber)
        
        onGiam?(mNumber)
    }
    
    @IBAction func onTangToched(_ sender: Any) {
        mNumber = mNumber - 1
        if mNumber > 100 {
            mNumber = 100
        }
        
        mNumLabel.text = String(mNumber)
        
        onTang?(mNumber)
    }
}
