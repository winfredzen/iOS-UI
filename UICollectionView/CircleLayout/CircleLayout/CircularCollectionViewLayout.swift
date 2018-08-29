//
//  CircularCollectionViewLayout.swift
//  CircleLayout
//
//  Created by 王振 on 2018/8/28.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class CircularCollectionViewLayout: UICollectionViewLayout {

    let itemSize = CGSize(width: 133, height: 173)
    
    var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0 ? -CGFloat(collectionView!.numberOfItems(inSection: 0) - 1) * anglePerItem : 0
    }
    var angle: CGFloat {
        return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize.width - collectionView!.bounds.width)
    }

    var radius : CGFloat = 500 {
        didSet {
            //重写布局
            invalidateLayout()
        }
    }
    
    //分隔的角度
    var anglePerItem: CGFloat {
        return atan(itemSize.width / radius)
    }
    
    var attributesList = [CircularCollectionViewLayoutAttributes]()
    
}

extension CircularCollectionViewLayout {
    
    override var collectionViewContentSize: CGSize {
        
        return CGSize(width: CGFloat(collectionView!.numberOfItems(inSection: 0)) * itemSize.width,
               height: collectionView!.bounds.height)
        
    }
    
    override class var layoutAttributesClass: AnyClass {
        return CircularCollectionViewLayoutAttributes.self
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    //This method is also called each time the layout is invalidated
    
    override func prepare() {
        
        super.prepare()
        
        let centerX = collectionView!.contentOffset.x + self.collectionView!.bounds.width / 2;
        
        // 1
        let theta = atan2(collectionView!.bounds.width / 2.0,
                          radius + (itemSize.height / 2.0) - collectionView!.bounds.height / 2.0)
        // 2
        var startIndex = 0
        var endIndex = collectionView!.numberOfItems(inSection: 0) - 1
        // 3
        if (angle < -theta) {
            startIndex = Int(floor((-theta - angle) / anglePerItem))
        }
        // 4
        endIndex = min(endIndex, Int(ceil((theta - angle) / anglePerItem)))
        // 5
        if (endIndex < startIndex) {
            endIndex = 0
            startIndex = 0
        }

        attributesList = (startIndex...endIndex).map { (i) -> CircularCollectionViewLayoutAttributes in
            
            //创建实例
            let attributes = CircularCollectionViewLayoutAttributes(forCellWith: IndexPath(row: i, section: 0))
            
            attributes.size = self.itemSize
            
            attributes.center = CGPoint(x: centerX, y: self.collectionView!.bounds.midY)
            
            attributes.angle = self.angle + (self.anglePerItem * CGFloat(i))
            
            //设置旋转中心
            let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
            
            return attributes
            
        }
        
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return attributesList
        
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        return attributesList[indexPath.item]
        
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        var finalContentOffset = proposedContentOffset
        let factor = -angleAtExtreme/(collectionViewContentSize.width - collectionView!.bounds.width)
        let proposedAngle = proposedContentOffset.x * factor
        let ratio = proposedAngle/anglePerItem
        var multiplier: CGFloat
        if (velocity.x > 0) {
            multiplier = ceil(ratio)
        } else if (velocity.x < 0) {
            multiplier = floor(ratio)
        } else {
            multiplier = round(ratio)
        }
        finalContentOffset.x = multiplier*anglePerItem/factor
        return finalContentOffset
        
    }
    
 
    
}

















