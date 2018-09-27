//
//  SlideShowViewController.swift
//  Store
//
//  Created by Apple on 9/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import ImageSlideshow
import AlamofireImage
import Alamofire

class SlideShowViewController: UIViewController {

    @IBOutlet var mSlideShow: ImageSlideshow!
    var imageDetailAlbum: [String]?
    var shoe: Shoe!
    var alamofireSource = [AlamofireSource]()
    override func viewDidLoad() {
       

        super.viewDidLoad()
        for item in imageDetailAlbum!{
            var itemURL = URL(string: item)
            alamofireSource.append(AlamofireSource(url: itemURL!))
        }
//        let alamofireSource = [AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]

//        var alamofireSource: [AlamofireSource]?
//        for item in imageDetailAlbum!{
//            let alamofireSourceItem = AlamofireSource(urlString: item)
//            alamofireSource?.append(alamofireSourceItem!)
//
//        }


        mSlideShow.slideshowInterval = 5.0
        mSlideShow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        mSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        mSlideShow.pageIndicator = pageControl
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        mSlideShow.activityIndicator = DefaultActivityIndicator()
        mSlideShow.currentPageChanged = { page in
            print("current page:", page)
        }
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        
        //set image
        mSlideShow.setImageInputs(alamofireSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(SlideShowViewController.didTap))
        mSlideShow.addGestureRecognizer(recognizer)    }

    @objc func didTap() {
        let fullScreenController = mSlideShow.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
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
