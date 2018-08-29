//
//  ViewController.swift
//  PDFKitDemo
//
//  Created by 王振 on 2018/8/29.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController {

    @IBOutlet weak var pdfView: PDFView!
    
    @IBOutlet weak var pdfThumbnailView: PDFThumbnailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "sample", ofType: "pdf") {
            
            let url = URL(fileURLWithPath: path);
            
            if let pdfDocument = PDFDocument(url: url) {
                
                pdfView.backgroundColor = .lightGray
                
//                pdfView.displayMode = .singlePageContinuous
                pdfView.autoScales = true
                //pdfView.displayDirection = .horizontal
                
//                pdfView.displaysPageBreaks = true
//                pdfView.pageBreakMargins = UIEdgeInsetsMake(10.0, 40.0, 10.0, 0.0)
                
//                pdfView.displayBox = .bleedBox
                
                
                
                pdfView.document = pdfDocument
                
            }
            
        }
        
        
        pdfThumbnailView.pdfView = pdfView
        pdfThumbnailView.layoutMode = .horizontal
        pdfThumbnailView.backgroundColor = UIColor.gray
        pdfThumbnailView.thumbnailSize = CGSize(width: 40, height: 40)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

