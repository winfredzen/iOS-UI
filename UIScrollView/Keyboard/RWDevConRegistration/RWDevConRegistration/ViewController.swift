//
//  ViewController.swift
//  RWDevConRegistration
//
//  Created by Brian on 2/16/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        adjustInsetForKeyboardShow(show: true, notification: notification)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        adjustInsetForKeyboardShow(show: false, notification: notification)
    }
    
    func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let adjustment = keyboardFrame.height * (show ? 1 : -1) + 20
        scrollView.contentInset.bottom += adjustment
        scrollView.scrollIndicatorInsets.bottom += adjustment
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //别人推荐的一中更简单的方法
    
    /*
    override func viewDidLoad() {
        ...
            NotificationCenter.default.addObserver(self, selector: #selector(adjustInsetsForKeyboard(notification:)), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardDidChangeFrame(notification: NSNotification) {
        adjustInsetsForKeyboard(notification: notification)
    }
    
    @objc func adjustInsetsForKeyboard(notification: NSNotification) {
        let userInfo = notification.userInfo ?? [:]
        let endKeyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let adjustment = abs(UIScreen.main.bounds.height - endKeyboardFrame.origin.y)
        fgScrollView.contentInset.bottom = adjustment
        fgScrollView.scrollIndicatorInsets.bottom = adjustment
    }
 
  */
    
    
}

