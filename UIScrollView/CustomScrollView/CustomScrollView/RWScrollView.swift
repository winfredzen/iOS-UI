//
//  RWScrollView.swift
//  CustomScrollView
//
//  Created by 王振 on 2017/12/16.
//  Copyright © 2017年 Razeware. All rights reserved.
//

import UIKit

class RWScrollView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        //添加拖动手势
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panView(with:)))
        addGestureRecognizer(panGesture)
    }
    
    //原理是：改变父view的origin的位置，会改变子view的位置
    
    //注意添加@objc
    @objc func panView(with gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self);
        print("translation.y: \(translation.y)")
        //动画
        UIView.animate(withDuration: 0.20) {
            self.bounds.origin.y = self.bounds.origin.y - translation.y
        }
        
        //reset 平移
        gestureRecognizer.setTranslation(CGPoint.zero, in: self)
    }
    
}
