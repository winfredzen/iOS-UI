//
//  CircularCollectionViewCell.swift
//  CircleLayout
//
//  Created by 王振 on 2018/8/28.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class CircularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView?
    
    var imageName: String = "" {
        didSet {
            imageView!.image = UIImage(named: imageName)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        contentView.layer.cornerRadius = 5
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
        contentView.clipsToBounds = true
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageView!.contentMode = .scaleAspectFill
        
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        
        super.apply(layoutAttributes)
        
        let circularlayoutAttributes = layoutAttributes as! CircularCollectionViewLayoutAttributes
        self.layer.anchorPoint = circularlayoutAttributes.anchorPoint
        self.center.y += (circularlayoutAttributes.anchorPoint.y - 0.5) * self.bounds.height
        
    }

}
