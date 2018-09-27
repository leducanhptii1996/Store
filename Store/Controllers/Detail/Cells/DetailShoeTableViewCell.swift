//
//  DetailShoeTableViewCell.swift
//  Store
//
//  Created by Apple on 9/7/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit


class DetailShoeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mShoeDetailName: UILabel!
    
    @IBOutlet weak var mDetailPriceLabel: UILabel!
    @IBOutlet weak var mDetailPriceValueLabel: UILabel!
    @IBOutlet weak var mShoeDetailPriceUnit: UILabel!
    
    @IBOutlet weak var mShoeDetailSize: UILabel!
    var shoe: Shoe?
    
    
   
    @IBOutlet weak var mSegmentSize: UISegmentedControl!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        // Initialization code
    }
    @IBAction func onSegmentValueChange(_ sender: UISegmentedControl) {
        switch(mSegmentSize.selectedSegmentIndex){
        case 0:
            shoe?.size = 36
            break
        case 1:
            shoe?.size = 37
            
            break
        case 2:
            shoe?.size = 38
            
            break
        case 3:
            shoe?.size = 39
            
            break
        case 4:
            shoe?.size = 40
            
            break
        case 5:
            shoe?.size = 41
            
            break
        case 6:
            shoe?.size = 42
            
            break
        case 7:
            shoe?.size = 43
            
            break
            
        default:
            shoe?.size = 1
            
            break
        }
    }
    func setDetailData(data: Shoe) {
        mShoeDetailName.text = data.name
        mDetailPriceValueLabel.text = data.price.formattedWithSeparator
        
       
    
        //        mShoeImage.image = UIImage(named: data.image)
    }
    
    
    
    
   
    
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    

}
