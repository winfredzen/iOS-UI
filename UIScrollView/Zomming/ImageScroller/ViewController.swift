//
//  ViewController.swift
//  ImageScroller
//
//  Created by Brian on 2/9/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        //scrollView.contentSize = (imageView.image?.size)!
        imageView.frame.size = (imageView.image?.size)!
        scrollView.delegate = self
        
        print("scrollView bounds: \(scrollView.bounds.size)")
        
        setZoomParameterForSize(scrollView.bounds.size)
        recenterImage()
    }
    
    //居中
    func recenterImage()  {
        let scrollViewSize = scrollView.bounds.size
        let imageSize = imageView.frame.size
        let horizontalSpace = imageSize.width < scrollViewSize.width ? (scrollViewSize.width - imageSize.width) / 2 : 0
        let verticalSpace = imageSize.height < scrollViewSize.height ? (scrollViewSize.height - imageSize.height) / 2 : 0
        scrollView.contentInset = UIEdgeInsets(top: verticalSpace, left: horizontalSpace, bottom: verticalSpace, right: horizontalSpace)
    }
    
    override func viewWillLayoutSubviews() {
        setZoomParameterForSize(scrollView.bounds.size)
        recenterImage()
    }
    
    //设置起始scale 匹配屏幕的宽或者高
    func setZoomParameterForSize(_ scrollViewSize: CGSize) {
        let imageSize = imageView.bounds.size
        let widthScale = scrollViewSize.width / imageSize.width
        let heightScale = scrollViewSize.height / imageSize.height
        let minScale = min(widthScale, heightScale)
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = minScale
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: UIScrollViewDelegate {
    //这里缩放的原理是，修改imageView的frame 但bounds没有改变
    //缩放的view
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        /**
         ***
         imageView frame: (0.0, 0.0, 414.0, 309.222222222222)
         imageView bounds: (0.0, 0.0, 2592.0, 1936.0)
         */
        print("imageView frame: \(imageView.frame)")
        print("imageView bounds: \(imageView.bounds)")
        
    }
    
}







