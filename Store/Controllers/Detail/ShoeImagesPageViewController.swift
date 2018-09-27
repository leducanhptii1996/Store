////
////  ShoeImagesPageViewController.swift
////  Store
////
////  Created by Apple on 9/5/18.
////  Copyright © 2018 Apple. All rights reserved.
////
//
//import UIKit
//import Nuke
//
//protocol ShoeImagesPageViewControllerDelegate: class
//{
//    func setupPageController(numberOfPages: Int)
//    func turnPageController(to index: Int)
//}
//class ShoeImagesPageViewController: UIPageViewController {
//
//    var mShoe =  [Shoe]()
//    var imageDetailAlbum: [String]?
//    var shoe: Shoe!
//    var imageView: UIImageView?
//
//
//    weak var pageViewControllerDelegate: ShoeImagesPageViewControllerDelegate?
//
//    
//    struct StoryBoard{
//        static let detailShoeImageViewController = "DetailShoeImageViewController"
//    }
//    //khoi tao mang các controller ở page view  hiển thị album ảnh
//    lazy var controllers: [UIViewController]? = {
//        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
//        var controllers = [UIViewController]()
//        if let images = self.imageDetailAlbum{
//            for image in images{
//                let shoeImageVC = storyboard.instantiateViewController(withIdentifier: "DetailShoeImageViewController")
////                    as! DetailShoeImageViewController
//               
//                
////                shoeImageVC.imageView = self.imageView
//                
//                controllers.append(shoeImageVC)
//            }
//        }
//        self.pageViewControllerDelegate?.setupPageController(numberOfPages: controllers.count)
//
//        return controllers
//        
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        automaticallyAdjustsScrollViewInsets = false
//        delegate = self
//        dataSource = self
//        self.turnToPage(index: 0)
//        
//        
//        //request data
//        AdidasTabService.getShoeData { (arrShoe) in
//            self.mShoe = arrShoe!
//        }
//        
//    }
//    
//    func turnToPage(index: Int){
//        //tạo 1 controller gán = controller ở vị trí index
//        var controller = controllers![index]
//        var direction = UIPageViewControllerNavigationDirection.forward
//        //tạo biến chứa vc hiện tại = viewcontroller đầu tiên trong mảng vc
//        if let currentVC = viewControllers?.first{
//            //biến chứa index hiện tại gán = index của currentVC
//            let currentIndex = controllers?.index(of: currentVC)
//            //nếu index hiện tại > index đc truyền vào
//            self.pageViewControllerDelegate?.turnPageController(to: currentIndex!)
//
//            if currentIndex! > index {
//                //đảo ngược hướng
//                direction = .reverse
//                
//            }
//
//            
//        }
//        //set các đặc tính cho view controller
//        self.configureDisplay(viewController: controller)
//        
//        setViewControllers([controller], direction: direction, animated: true, completion: nil)
//    }
//
//    func configureDisplay(viewController: UIViewController){
//        //for(index,vc) duyệt vị trí và phần tử
//        for(index,vc) in (controllers?.enumerated())!{
//            //nếu param = và cùng kiều với view controller ở vị trí index trong controllers
//            if viewController == vc{
//                if let shoeImageVC = vc as? DetailShoeImageViewController{
//                    print(index)
//                    
//                    shoeImageVC.url = (self.imageDetailAlbum?[index])!
//                    shoeImageVC.image = UIImage(named: shoe.albumImage![index])
//
//                    self.pageViewControllerDelegate?.turnPageController(to: index)
//                }
//                
//            }
//           
//            
//            
//
//
//            
//
//        
//         
//        }
//        
//    }
//
//    
//    
//
//}
////UIPageViewControllerDatasource extension
//extension ShoeImagesPageViewController:UIPageViewControllerDataSource{
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        if let index = controllers?.index(of: viewController){
//            if index > 0{
//                return controllers?[index-1]
//            }
//        }
//        return controllers?.last
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        if let index = controllers?.index(of: viewController){
//            if index < (controllers?.count)! - 1{
//                return controllers?[index + 1]
//            }
//        }
//        return controllers?.first
//    }
//    
//    
//}
//extension ShoeImagesPageViewController:UIPageViewControllerDelegate{
//    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
//        self.configureDisplay(viewController: pendingViewControllers.first as! DetailShoeImageViewController)
//    }
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        if !completed{
//            self.configureDisplay(viewController: previousViewControllers.first as! DetailShoeImageViewController)
//        }
//    }
//}
