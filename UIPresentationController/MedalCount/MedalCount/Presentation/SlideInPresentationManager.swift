//
//  SlideInPresentationManager.swift
//  MedalCount
//
//  Created by 王振 on 2019/3/4.
//  Copyright © 2019 Ron Kliffer. All rights reserved.
//

import UIKit

//展示的方向
enum PresentationDirection {
  case left
  case top
  case right
  case bottom
}

class SlideInPresentationManager: NSObject {

  var direction = PresentationDirection.left
  
  //是否支持compact height
  var disableCompactHeight = false

  
}

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {

  func presentationController(forPresented presented: UIViewController,
                              presenting: UIViewController?,
                              source: UIViewController) -> UIPresentationController? {
    let presentationController = SlideInPresentationController(presentedViewController: presented,
                                                               presentingViewController: presenting,
                                                               directon: direction)
    presentationController.delegate = self
    
    return presentationController
  }
  
  //present
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    return SlideInPresentationAnimator(direction: direction, isPresentation: true)
    
  }
  
  //dismiss
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    return SlideInPresentationAnimator(direction: direction, isPresentation: false)
    
  }
  
}

//响应size改变
extension SlideInPresentationManager: UIAdaptivePresentationControllerDelegate {
  
  func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
    
    if traitCollection.verticalSizeClass == .compact && disableCompactHeight {
      
      return .overFullScreen
      
    } else {
      
      return .none
      
    }
    
  }
  
  func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
    
    guard style == .overFullScreen else { return nil }
    
    return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RotateViewController")
    
  }
  
}
