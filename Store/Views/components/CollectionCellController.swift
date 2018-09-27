//
//  CollectionCellController.swift
//  Store
//
//  Created by Apple on 9/4/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Nuke

class CollectionCellController: UICollectionViewCell {

    @IBOutlet weak var mShoeImage: UIImageView!
    
    @IBOutlet weak var mShoeNameLabel: UILabel!
    
    @IBOutlet weak var mShoePriceLabel: UILabel!
     func setPlaceHolder(){
        mShoeImage.image = UIImage(named: "empty placeholder")

    }
    func setData(data: Shoe) {

        mShoeNameLabel.text = data.name
        mShoePriceLabel.text = data.price.formattedWithSeparator + " VND"
        var url: String?
        url = data.representImage
        
        let request = ImageRequest(urlRequest: URLRequest(url: URL(string: url!)!))
        Nuke.loadImage(with: request, into: mShoeImage)
//        mShoeImage.image = UIImage(named: data.image)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
