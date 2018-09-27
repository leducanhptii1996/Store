    //
//  DetailShoeImageViewController.swift
//  Store
//
//  Created by Apple on 9/5/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import ImageSlideshow
import Nuke

  
class DetailShoeImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
////    var shoe: Shoe!
//    var url: String?
////    var url: String?{
////        didSet{
////            setImageData()
////        }
////    }
    var url: String?
    var image: UIImage? {
        didSet {
//            let data = try? Data(contentsOf: URL(url)!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//            imageView.image = UIImage(data: data!)
            self.imageView.image = image
        }
    }
//    func setImageData(){
//
//        let request = ImageRequest(urlRequest: URLRequest(url: URL(string: url!)!))
//            Nuke.loadImage(with: request, into: imageView)
//
//
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        setImageData()

//        setImageData()
     
        self.imageView?.image = image

    }
    
    
    

   
}
